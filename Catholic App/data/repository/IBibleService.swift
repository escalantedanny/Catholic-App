
protocol IBibleService {
    func fetchRandomVersicle() async throws -> Versiculo
    func saveFavoriteVersicle(_ versiculo: Versiculo) async
    func deleteFavoriteVersicle(_ versiculo: Versiculo) async
    func isFavorite(_ versiculo: Versiculo) -> Bool
    func loadFavoriteFromDisk() -> [Versiculo]
    func getFavoriteVerses() -> [Versiculo]
    func fetchEvangelioDelDia() async throws -> EvangelioResponse
    func searchVersicle(query: String, retryCount: Int) async throws -> [Versiculo]
    func fetchDetailBook(libro: String, chapter: Int, retryCount: Int) async throws -> ChapterResponse
    func fetchLibros(retryCount: Int) async throws -> [String]
    func fetchLibro(libro: String, retryCount: Int) async throws -> BookResponse
    func fetchFaithEvents(retryCount: Int) async throws -> [FaithEvent]
}
