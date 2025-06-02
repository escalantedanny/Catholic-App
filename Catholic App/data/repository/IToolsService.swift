protocol IToolsService {
    func fetchSaintsOfDay(month: Int, day: Int) async throws -> [LiturgicalEvent]
}
