import Foundation
import CacheManager

class BibleServiceImpl: IBibleService {

    private var favoritos: [Versiculo] = []
    private var isFavorite: Bool = false
    private var cache: CacheService
    private var evangelio: EvangelioResponse?
    private var session: URLSession
    
    init(cache: CacheManager) {
        self.cache = cache
        let config = URLSessionConfiguration.ephemeral
            config.timeoutIntervalForRequest = 20
            config.timeoutIntervalForResource = 20
        self.session = URLSession(configuration: config)
    }
    
    func loadFavoriteFromDisk() -> [Versiculo] {
        return self.cache.get(forKey: "FAVORITE_LIST") ?? []
    }
    
    func getFavoriteVerses() -> [Versiculo] {
        return self.cache.get(forKey: "FAVORITE_LIST") ?? []
    }
    
    
    func saveFavoriteVersicle(_ versiculo: Versiculo) {
        
        guard !isFavorite(versiculo) else { return }

        favoritos.append(versiculo)
        cache.save(favoritos, forKey: "FAVORITE_LIST", expiration: .never)
        print("✅ Versículo guardado en favoritos.")

    }
    
    func deleteFavoriteVersicle(_ versiculo: Versiculo)  {
        
        var favoritos = loadFavoriteFromDisk()

        favoritos.removeAll(where: {
            $0.libro == versiculo.libro &&
            $0.capitulo == versiculo.capitulo &&
            $0.versiculo == versiculo.versiculo
        })
        
        self.cache.save(favoritos, forKey: "FAVORITE_LIST", expiration: .never)
        print("🗑️ Versículo eliminado de favoritos.")
        self.favoritos = favoritos
    }
    
    func isFavorite(_ versiculo: Versiculo) -> Bool {
        return favoritos.contains(where: {
            $0.libro == versiculo.libro &&
            $0.capitulo == versiculo.capitulo &&
            $0.versiculo == versiculo.versiculo
        })
    }
    
    func fetchRandomVersicle() async throws -> Versiculo {
        let cacheKey = "RANDOM_VERSICLE"
        
        if let cached: Versiculo = cache.get(forKey: cacheKey) {
            print("📦 Versículo cargado desde caché")
            return cached
        }
        
        guard let url = URL(string: Constants.urls.randomVersicles) else {
            throw URLError(.badURL)
        }
        
        for attempt in 1...3 {
            do {
                let (data, _) = try await session.data(from: url)
                let versiculo = try JSONDecoder().decode(Versiculo.self, from: data)
                cache.save(versiculo, forKey: cacheKey, expiration: .hours(24))
                print("🌐 Versículo descargado desde red")
                return versiculo
            } catch {
                print("❌ Error en intento \(attempt): \(error.localizedDescription)")
                if attempt < 3 {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                }
            }
        }
        
        throw URLError(.cannotLoadFromNetwork)
    }
    
    func fetchEvangelioDelDia() async throws -> EvangelioResponse {
        
        guard let url = URL(string: Constants.urls.evangelio) else {
            print("❌ URL inválida.")
            throw URLError(.badURL)
        }
        
        let hoy = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let hoyString = formatter.string(from: hoy)
        
        if let cached: EvangelioResponse = cache.get(forKey: "evangelio-\(hoyString)"),
           cached.fecha == hoyString {
            print("📦 Evangelio del día cargado desde caché")
            return cached
        }
        

        for attempt in 1...3 {
            do {
                print("🌐 Intento \(attempt): solicitando desde \(url.absoluteString)")
                let (data, _) = try await session.data(from: url)
                
                guard let jsonString = String(data: data, encoding: .utf8) else {
                    print("⚠️ No se pudo decodificar a UTF8.")
                    continue
                }

                print("📦 Datos recibidos:\n\(jsonString)")

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(EvangelioResponse.self, from: data)
                let now = Date()
                let calendar = Calendar.current
                if let midnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0), matchingPolicy: .nextTime) {
                    let intervalUntilMidnight = midnight.timeIntervalSince(now)
                    cache.save(response, forKey: "evangelio-\(response.fecha)", expiration: .custom(intervalUntilMidnight))
                }
                print("✅ Evangelio recibido correctamente.")
                return response

            } catch {
                print("❌ Error en el intento \(attempt): \(error.localizedDescription)")
                if attempt < 3 {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    print("🔁 Reintentando...")
                }
            }
        }

        throw URLError(.cannotLoadFromNetwork)
    }
    
    func searchVersicle(query: String, retryCount: Int) async throws -> [Versiculo] {
        
        let cacheKey = "SEARCH_QUERY_\(query.lowercased())"
        
        if let cachedResults: [Versiculo] = self.cache.get(forKey: cacheKey) {
            print("📦 Resultados de búsqueda recuperados desde caché para '\(query)'")
            return cachedResults
        }
        
        guard var urlComponents = URLComponents(string: Constants.urls.search) else {
            print("❌ URL inválida")
            throw URLError(.badURL)
        }

        urlComponents.queryItems = [URLQueryItem(name: "q", value: query)]
        
        guard let url = urlComponents.url else {
            print("❌ No se pudo construir la URL con query")
            throw URLError(.badURL)
        }

        for attempt in 1...retryCount {
            do {
                let (data, _) = try await session.data(from: url)
                print("🛰️ Request de búsqueda: \(url.absoluteString)")
                print("📦 Resultado búsqueda: \(String(data: data, encoding: .utf8) ?? "Invalid UTF8")")
                let resultado = try JSONDecoder().decode([Versiculo].self, from: data)
                self.cache.save(resultado, forKey: cacheKey, expiration: .never)
                return resultado
            } catch {
                print("❌ Error en búsqueda intento \(attempt): \(error.localizedDescription)")
                if attempt < retryCount {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                }
            }
        }
        throw URLError(.cannotLoadFromNetwork)
    }
    
    func fetchDetailBook(libro: String, chapter: Int, retryCount: Int) async throws -> ChapterResponse {
        
        guard let url = URL(string: "\(Constants.urls.base)/\(libro)/capitulos/\(chapter)") else {
            throw URLError(.badURL)
        }
        
        let cacheKey = "DETAIL_BOOK_\(libro.uppercased())_\(chapter)"

        if let randomVersicle: ChapterResponse = self.cache.get(forKey: cacheKey) {
            print("📦 randomVersicle cargado desde caché")
            return randomVersicle
        }

        for attempt in 1...retryCount {
            do {
                let (data, _) = try await session.data(from: url)
                let _chapter = try JSONDecoder().decode(ChapterResponse.self, from: data)
                self.cache.save(_chapter, forKey: cacheKey, expiration: .never)
                print("✅ chapter cargado correctamente")
                print(_chapter)
                return _chapter
            } catch {
                print("❌ Error intento \(attempt): \(error.localizedDescription)")
                if attempt < retryCount {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                }
            }
        }
        throw URLError(.cannotLoadFromNetwork)
    }
    
    func fetchLibros(retryCount: Int) async throws -> [String] {
        
        guard let url = URL(string: Constants.urls.books) else { throw URLError(.badURL) }
        
        if let booksSave: [String] = self.cache.get(forKey: "BOOKS") {
            print("📦 Libros cargados desde caché")
            return booksSave
        }

        for attempt in 1...retryCount {
            do {
                let (data, _) = try await session.data(from: url)
                let _books = try JSONDecoder().decode([String].self, from: data)
                self.cache.save(_books, forKey: "BOOKS", expiration: .never)
                print("✅ Libros cargados correctamente")
                return _books
            } catch {
                print("❌ Error intento \(attempt): \(error.localizedDescription)")
                if attempt < retryCount {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                }
            }
        }
        throw URLError(.cannotLoadFromNetwork)
    }
    
    func fetchLibro(libro: String, retryCount: Int) async throws -> BookResponse {
        guard let url = URL(string: "\(Constants.urls.books)/\(libro)") else { throw URLError(.badURL) }

        if let bookSave: BookResponse = self.cache.get(forKey: "BOOK_\(libro.uppercased())") {
            print("📦 Libro cargado desde caché")
            return bookSave
        }

        for attempt in 1...retryCount {
            do {
                let (data, _) = try await session.data(from: url)
                let _book = try JSONDecoder().decode(BookResponse.self, from: data)
                self.cache.save(_book, forKey: "BOOK_\(libro.uppercased())", expiration: .never)
                print("✅ Libro cargado correctamente")
                return _book
            } catch {
                print("❌ Error intento \(attempt): \(error.localizedDescription)")
                if attempt < retryCount {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                }
            }
        }
        throw URLError(.cannotLoadFromNetwork)
    }
    
    func fetchFaithEvents(retryCount: Int) async throws -> [FaithEvent] {
        
        guard let url = URL(string: "https://bible-api-a2sa.onrender.com/libros/events") else {
            throw URLError(.badURL)
        }

        if let cachedEvents: [FaithEvent] = self.cache.get(forKey: "FAITH_EVENTS") {
            print("📦 Eventos cargados desde caché")
            return cachedEvents
        }

        // Reintentos en caso de fallo
        for attempt in 1...retryCount {
            do {
                let (data, _) = try await session.data(from: url)

                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)

                let events = try decoder.decode([FaithEvent].self, from: data)
                self.cache.save(events, forKey: "FAITH_EVENTS", expiration: .never)

                print("✅ Eventos cargados correctamente")
                return events
            } catch {
                print("❌ Error intento \(attempt): \(error.localizedDescription)")

                if attempt < retryCount {
                    try? await Task.sleep(nanoseconds: 1_000_000_000) // Espera 1 segundo
                }
            }
        }

        throw URLError(.cannotLoadFromNetwork)
    }
    
}
