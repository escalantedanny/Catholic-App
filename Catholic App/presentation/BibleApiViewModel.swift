import SwiftUI
import Combine

class BibleApiViewModel: ObservableObject {
    
    @Published var versiculo: Versiculo?
    @Published var versiculos: [Versiculo] = []
    @Published var books: [String] = []
    @Published var book: BookResponse?
    @Published var chapter: ChapterResponse?
    @Published var evangelio: EvangelioResponse?
    @Published var favoritos: [Versiculo] = []
    @Published var faithEvents: [FaithEvent] = []
    @Published var liturgiaTitle: String = ""

    private let bibleService: IBibleService
    
    init (bibleService: IBibleService) {
        self.bibleService = bibleService
        self.favoritos = favoritos
        self.faithEvents = faithEvents
        self.liturgiaTitle = ""
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

    func deleteFavorite(versiculo: Versiculo) {
        Task {
            await bibleService.deleteFavoriteVersicle(versiculo)
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
            formatearFechaLiturgia(self.evangelio?.fecha ?? "")
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
    
    @MainActor
    func loadEvents(retryCount: Int = 3) async {
        do {
            self.faithEvents = try await bibleService.fetchFaithEvents(retryCount: retryCount)
        } catch {
            print("❌ Error: \(error)")
        }
    }
    
    func formatearFechaLiturgia(_ fechaStr: String) {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        inputFormatter.locale = Locale(identifier: "es_ES")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE d 'de' MMMM 'de' yyyy"
        outputFormatter.locale = Locale(identifier: "es_ES")

        if let date = inputFormatter.date(from: fechaStr) {
            let fechaFormateada = outputFormatter.string(from: date).capitalized
            self.liturgiaTitle = fechaFormateada
        }
    }
    
}
