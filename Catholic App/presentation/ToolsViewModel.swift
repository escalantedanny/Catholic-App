import Foundation

class ToolsViewModel: ObservableObject {
    
    private let toolsService: IToolsService
    
    init(toolsService: IToolsService) {
        self.toolsService = toolsService
    }

    func fetchSaintsOfDay(month: Int, day: Int) async -> [LiturgicalEvent] {
        do {
            return try await toolsService.fetchSaintsOfDay(month: month, day: day)
        } catch {
            print("Error fetching saints of day \(day)/\(month): \(error)")
            return []
        }
    }
}
