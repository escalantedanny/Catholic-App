import Foundation


class CheckHealthModel: ObservableObject {
    
    private let healthService: IHealthService
    
    @Published var status: String = "Desconocido"
    @Published var isLoading: Bool = false

    init(healthService: IHealthService) {
        self.healthService = healthService
    }
    
    @MainActor
    func check() async {
        isLoading = true
        do {
            let result = try await healthService.checkHealth(retryCount: 3)
            status = result
        } catch {
            status = "Error: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
}
