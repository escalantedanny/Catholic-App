
protocol IHealthService {
    func checkHealth(retryCount: Int) async throws -> String
}
