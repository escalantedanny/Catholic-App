import SwiftUI
import CacheManager
import Combine

class BibleApiViewModel: ObservableObject {
    
    @Published var status: String = "Desconocido"
    @Published var versiculo: Versiculo?
    @Published var versiculos: [Versiculo] = []
    @Published var books: [String] = []
    @Published var book: BookResponse?
    @Published var chapter: ChapterResponse?
    @Published var evangelio: EvangelioResponse?
    @Published var isLoading: Bool = false
    @Published var favoritos: [Versiculo] = []

    private let bibleService: IBibleService
    
    private var cancellables = Set<AnyCancellable>()
    private var cache: CacheService
    private var session: URLSession
    
    init (cache: CacheManager, bibleService: IBibleService) {
        self.cache = cache
        self.bibleService = bibleService
        let config = URLSessionConfiguration.ephemeral
            config.timeoutIntervalForRequest = 20
            config.timeoutIntervalForResource = 20
            self.session = URLSession(configuration: config)
        loadFavoritosFromCache()
    }
    
    private func loadFavoritosFromCache() {
        favoritos = cache.get(forKey: "FAVORITE_LIST") ?? []
    }
    
    @MainActor
    func fetchRandomVersicle(retryCount: Int = 3) async {
        
        isLoading = true
        defer { isLoading = false }
        do {
            let result = try await bibleService.fetchRandomVersicle()
            self.versiculo = result
            self.status = "Versículo cargado correctamente"
        } catch {
            print("❌ Error al obtener versículo: \(error)")
            self.status = "Error: \(error.localizedDescription)"
        }
    }
    
    @MainActor
    func fetchLibros(retryCount: Int = 3) async {
        guard let url = URL(string: Constants.urls.books) else { return }
        
        if let booksSave: [String] = self.cache.get(forKey: "BOOKS") {
            self.books = booksSave
            print("📦 Libros cargados desde caché")
            return
        }

        for attempt in 1...retryCount {
            do {
                let (data, _) = try await session.data(from: url)
                let _books = try JSONDecoder().decode([String].self, from: data)
                self.cache.save(_books, forKey: "BOOKS", expiration: .never)
                self.books = _books
                print("✅ Libros cargados correctamente")
                return
            } catch {
                print("❌ Error intento \(attempt): \(error.localizedDescription)")
                if attempt < retryCount {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                }
            }
        }
    }
    
    @MainActor
    func fetchLibro(libro: String, retryCount: Int = 3) async {
        guard let url = URL(string: "\(Constants.urls.books)/\(libro)") else { return }

        // Obtener desde caché si está disponible
        if let bookSave: BookResponse = self.cache.get(forKey: "BOOK_\(libro.uppercased())") {
            self.book = bookSave
            print("📦 Libro cargado desde caché")
            return
        }

        // Intentar descargar si no está en caché
        for attempt in 1...retryCount {
            do {
                let (data, _) = try await session.data(from: url)
                let _book = try JSONDecoder().decode(BookResponse.self, from: data)
                self.cache.save(_book, forKey: "BOOK_\(libro.uppercased())", expiration: .never)
                self.book = _book
                print("✅ Libro cargado correctamente")
                return
            } catch {
                print("❌ Error intento \(attempt): \(error.localizedDescription)")
                if attempt < retryCount {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                }
            }
        }
    }
    
    @MainActor
    func fetchDetailBook(libro: String, chapter: Int, retryCount: Int = 3) async {
        guard let url = URL(string: "https://bible-api-a2sa.onrender.com/libros/\(libro)/capitulos/\(chapter)") else { return }
        
        let cacheKey = "DETAIL_BOOK_\(libro.uppercased())_\(chapter)"

        if let randomVersicle: ChapterResponse = self.cache.get(forKey: cacheKey) {
            self.chapter = randomVersicle
            print("📦 randomVersicle cargado desde caché")
            return
        }

        for attempt in 1...retryCount {
            do {
                let (data, _) = try await session.data(from: url)
                let _chapter = try JSONDecoder().decode(ChapterResponse.self, from: data)
                self.chapter = _chapter
                self.cache.save(_chapter, forKey: cacheKey, expiration: .never)
                print("✅ chapter cargado correctamente")
                print(_chapter)
                return
            } catch {
                print("❌ Error intento \(attempt): \(error.localizedDescription)")
                if attempt < retryCount {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                }
            }
        }
    }

    func isFavorite(_ versiculo: Versiculo) -> Bool {
        favoritos.contains(where: {
            $0.libro == versiculo.libro &&
            $0.capitulo == versiculo.capitulo &&
            $0.versiculo == versiculo.versiculo
        })
    }

    @MainActor
    func saveFavoriteVersicle(versiculo: Versiculo) {
        guard !isFavorite(versiculo) else { return }

        favoritos.append(versiculo)
        cache.save(favoritos, forKey: "FAVORITE_LIST", expiration: .never)
        print("✅ Versículo guardado en favoritos.")
    }

    @MainActor
    func deleteFavoriteVersicle(versiculo: Versiculo) {
        favoritos.removeAll(where: {
            $0.libro == versiculo.libro &&
            $0.capitulo == versiculo.capitulo &&
            $0.versiculo == versiculo.versiculo
        })
        cache.save(favoritos, forKey: "FAVORITE_LIST", expiration: .never)
        print("🗑️ Versículo eliminado de favoritos.")
    }
    
    @MainActor
    func searchVersicle(query: String, retryCount: Int = 3) async {
        
        let cacheKey = "SEARCH_QUERY_\(query.lowercased())"
        
        if let cachedResults: [Versiculo] = self.cache.get(forKey: cacheKey) {
            print("📦 Resultados de búsqueda recuperados desde caché para '\(query)'")
            self.versiculos = cachedResults
            return
        }
        
        guard var urlComponents = URLComponents(string: Constants.urls.search) else {
            print("❌ URL inválida")
            return
        }

        urlComponents.queryItems = [URLQueryItem(name: "q", value: query)]
        
        guard let url = urlComponents.url else {
            print("❌ No se pudo construir la URL con query")
            return
        }

        for attempt in 1...retryCount {
            do {
                let (data, _) = try await session.data(from: url)
                print("🛰️ Request de búsqueda: \(url.absoluteString)")
                print("📦 Resultado búsqueda: \(String(data: data, encoding: .utf8) ?? "Invalid UTF8")")
                let resultado = try JSONDecoder().decode([Versiculo].self, from: data)
                self.cache.save(resultado, forKey: cacheKey, expiration: .never)
                DispatchQueue.main.async {
                    self.versiculos = resultado
                }
                return
            } catch {
                print("❌ Error en búsqueda intento \(attempt): \(error.localizedDescription)")
                if attempt < retryCount {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                }
            }
        }
    }
    
    func getFavoriteVerses() -> [Versiculo] {
        return cache.get(forKey: "FAVORITE_LIST") ?? []
    }
    
    @MainActor
    func fetchEvangelioDelDia(retryCount: Int = 3) async {
        guard let url = URL(string: Constants.urls.evangelio) else {
            print("❌ URL inválida.")
            return
        }

        for attempt in 1...retryCount {
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

                self.evangelio = response
                print("✅ Evangelio recibido correctamente.")
                return
            } catch {
                print("❌ Error en el intento \(attempt): \(error.localizedDescription)")
                if attempt < retryCount {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    print("🔁 Reintentando...")
                } else {
                    print("🛑 Se agotaron los intentos.")
                }
            }
        }
    }
    
}
