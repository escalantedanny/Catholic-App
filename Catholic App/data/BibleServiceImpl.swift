import Foundation
import CacheManager

class BibleServiceImpl: IBibleService {
    
    private var cache: CacheService
    
    init(cache: CacheManager) {
        self.cache = cache
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
                let (data, _) = try await URLSession.shared.data(from: url)
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
}
