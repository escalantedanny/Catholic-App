import Foundation
import CacheManager

class ToolsServiceImpl: IToolsService {

    private var cache: CacheService
    private var eventList: [LiturgicalEvent] = []

    init(cache: CacheService) {
        self.cache = cache
    }

    func fetchSaintsOfDay(month: Int, day: Int) async throws -> [LiturgicalEvent] {
        let cacheKey = "saints-\(String(format: "%02d", month))-\(String(format: "%02d", day))"

        if let cachedSantos: [SantoResponse] = self.cache.get(forKey: cacheKey), !cachedSantos.isEmpty {
            print("📦 Obteniendo santos desde caché para la clave: \(cacheKey)")
            self.eventList = cachedSantos.map { santo in
                LiturgicalEvent(
                    date: dateFrom(month: month, day: day),
                    title: santo.name,
                    description: santo.description,
                    type: .saint,
                    link: santo.link
                )
            }
            return self.eventList
        }

        guard let url = URL(string: "\(Constants.urls.saints)\(month)/\(day)") else {
            throw URLError(.badURL)
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                throw URLError(.badServerResponse)
            }

            let santos = try JSONDecoder().decode([SantoResponse].self, from: data)

            self.cache.save(santos, forKey: cacheKey, expiration: .never)

            self.eventList = santos.map { santo in
                LiturgicalEvent(
                    date: dateFrom(month: month, day: day),
                    title: santo.name,
                    description: santo.description,
                    type: .saint,
                    link: santo.link
                )
            }

            return self.eventList

        } catch {
            print("🌐 Error al obtener desde red: \(error.localizedDescription)")

            if let cachedSantos: [SantoResponse] = self.cache.get(forKey: cacheKey), !cachedSantos.isEmpty {
                print("📴 Sin conexión. Usando datos en caché.")
                self.eventList = cachedSantos.map { santo in
                    LiturgicalEvent(
                        date: dateFrom(month: month, day: day),
                        title: santo.name,
                        description: santo.description,
                        type: .saint,
                        link: santo.link
                    )
                }
                return self.eventList
            }

            throw error
        }
    }

    private func dateFrom(month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.month = month
        components.day = day
        components.year = Calendar.current.component(.year, from: Date())
        return Calendar.current.date(from: components) ?? Date()
    }
}
