import SwiftUI
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
    @Published var isFavorite: Bool = false
    @Published var favoritos: [Versiculo] = []

    private let bibleService: IBibleService
    
    private var cancellables = Set<AnyCancellable>()
    
    init (bibleService: IBibleService) {
        self.bibleService = bibleService
        self.favoritos = favoritos
        loadFavoritosFromCache()
    }
    
    func loadFavoritosFromCache() {
        self.favoritos = bibleService.loadFavoriteFromDisk()
    }
    
    @MainActor
    func fetchRandomVersicle(retryCount: Int = 3) async {

        do {
            self.versiculo = try await bibleService.fetchRandomVersicle()
        } catch {
            print("❌ Error al obtener versículo: \(error)")
        }
    }

    func isFavorite(_ versiculo: Versiculo) -> Bool {
        return bibleService.isFavorite(versiculo)
    }


    func saveFavoriteVersicle(versiculo: Versiculo) {
        Task {
            await bibleService.saveFavoriteVersicle(versiculo)
        }
    }

    func deleteFavorite(versiculo: Versiculo) async {
        do {
            self.favoritos = try await bibleService.deleteFavoriteVersicle(versiculo)
        } catch {
            print("❌ Error al obtener el evangelio: \(error)")
        }
    }
    
    func getFavoriteVerses() -> [Versiculo] {
        return bibleService.getFavoriteVerses()
    }

    
    @MainActor
    func searchVersicle(query: String, retryCount: Int = 3) async {
        do {
            self.versiculos = try await bibleService.searchVersicle(query: query, retryCount: retryCount)
        } catch {
            print("❌ Error al obtener el evangelio: \(error)")
        }
    }
    
    
    @MainActor
    func fetchEvangelioDelDia() async {
        do {
            self.evangelio = try await bibleService.fetchEvangelioDelDia()
        } catch {
            print("❌ Error al obtener el evangelio: \(error)")
        }
    }
    
    @MainActor
    func fetchDetailBook(libro: String, chapter: Int, retryCount: Int = 3) async {
        do {
            self.chapter = try await bibleService.fetchDetailBook(libro: libro, chapter: chapter, retryCount: retryCount)
        } catch {
            print("❌ Error al obtener el chapter: \(error)")
        }
    }
    
    @MainActor
    func fetchLibros(retryCount: Int = 3) async {
        do {
            self.books = try await bibleService.fetchLibros(retryCount: retryCount)
        } catch {
            print("❌ Error al obtener los libros: \(error)")
        }
    }
    
    @MainActor
    func fetchLibro(libro: String, retryCount: Int = 3) async {
        do {
            self.book = try await bibleService.fetchLibro(libro: libro, retryCount: retryCount)
        } catch {
            print("❌ Error al obtener los libros: \(error)")
        }
    }
    
}
