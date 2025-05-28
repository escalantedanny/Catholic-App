
import Combine
import SwiftUI

protocol RestClient {
    /// Retrieves a JSON resource and decodes it
    func get<T: Decodable, E: Endpoint>(_ endpoint: E) -> AnyPublisher<T, Error>
    
}

enum HealthStatus: String {
    case ok
    case disconnected
}

class HealthServiceImpl: IHealthService {
    
    private var session: URLSession
    
    init(session: URLSession = .shared) {
        let config = URLSessionConfiguration.ephemeral
            config.timeoutIntervalForRequest = 20
            config.timeoutIntervalForResource = 20
            self.session = URLSession(configuration: config)
    }
    
    
    func checkHealth(retryCount: Int) async throws -> String {
        guard let url = URL(string: Constants.urls.checkHealth ) else {
            return HealthStatus.disconnected.rawValue
        }
        
        for attempt in 1...retryCount {
            do {
                let (data, _) = try await session.data(from: url)
                print("🛰️ Requesting versículo from \(url.absoluteString)")
                print("📦 Data received: \(String(data: data, encoding: .utf8) ?? "Invalid UTF8")")
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                print("✅ response recibido: \(response)")

                return response.status
            } catch {
                print("❌ Error intento \(attempt): \(error.localizedDescription)")
                if attempt < retryCount {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                }
            }
        }
        throw URLError(.cannotConnectToHost)
    }
}
