import Foundation


class CheckHealthModel: ObservableObject {
    
    private let healthService: IHealthService
    
    init(healthService: IHealthService) {
        self.healthService = healthService
    }
    
    func checkHealth() async throws {
        let result = try await healthService.checkHealth(retryCount: 3)
        print("📡 Estado del servidor: \(result)")
    }
    
}
