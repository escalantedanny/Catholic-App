
protocol IBibleService {
    func fetchRandomVersicle() async throws -> Versiculo
    func saveFavoriteVersicle(_ versiculo: Versiculo) async
    func deleteFavoriteVersicle(_ versiculo: Versiculo) async
    func isFavorite(_ versiculo: Versiculo) -> Bool
    func loadFavoriteFromDisk() -> [Versiculo]
    func getFavoriteVerses() -> [Versiculo]
}
