import SwiftUI
import CacheManager
import Combine

class BibleApiViewModel: ObservableObject {
    
    @Published var versiculo: Versiculo?
    @Published var versiculos: [Versiculo] = []
    @Published var books: [String] = []
    @Published var book: BookResponse?
    @Published var chapter: ChapterResponse?
    private var cancellables = Set<AnyCancellable>()
    private var cache: CacheService
    private var session: URLSession
    
    init (cache: CacheManager) {
        self.cache = cache
        let config = URLSessionConfiguration.ephemeral
            config.timeoutIntervalForRequest = 20
            config.timeoutIntervalForResource = 20
            self.session = URLSession(configuration: config)
    }
    
    @MainActor
    func fetchRandomVersicle(retryCount: Int = 3) async {
        guard let url = URL(string: Constants.urls.randomVersicles ) else { return }

        for attempt in 1...retryCount {
            do {
                let (data, _) = try await session.data(from: url)
                print("🛰️ Requesting versículo from \(url.absoluteString)")
                print("📦 Data received: \(String(data: data, encoding: .utf8) ?? "Invalid UTF8")")
                let versiculo = try JSONDecoder().decode(Versiculo.self, from: data)
                self.versiculo = versiculo
                self.cache.save(versiculo, forKey: "VERSICLE", expiration: .never)
                print("✅ Versículo recibido: \(versiculo.texto)")

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
                self.cache.save(_book, forKey: "BOOK_SELECTED", expiration: .never)
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

        // Intentar descargar si no está en caché
        for attempt in 1...retryCount {
            do {
                let (data, _) = try await session.data(from: url)
                let _chapter = try JSONDecoder().decode(ChapterResponse.self, from: data)
                //self.cache.save(_book, forKey: "BOOK_SELECTED", expiration: .never)
                self.chapter = _chapter
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
    
    @MainActor
    func saveFavoriteVersicle(versiculo: Versiculo) {
        var favoritos: [Versiculo] = self.cache.get(forKey: "FAVORITE_LIST") ?? []

        if !favoritos.contains(where: {
            $0.libro == versiculo.libro &&
            $0.capitulo == versiculo.capitulo &&
            $0.versiculo == versiculo.versiculo
        }) {
            favoritos.append(versiculo)
            self.cache.save(favoritos, forKey: "FAVORITE_LIST", expiration: .never)
            print("✅ Versículo guardado en favoritos.")
        } else {
            print("⚠️ El versículo ya está en favoritos.")
        }

        print("Favoritos actuales:", favoritos)
    }
    
    @MainActor
    func searchVersicle(query: String, retryCount: Int = 3) async {
        
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
                let resultado = try JSONDecoder().decode([Versiculo].self, from: data) // <-- nota: lista
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
    
}
