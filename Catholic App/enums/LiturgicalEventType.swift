import Foundation

enum LiturgicalEventType: String {
    case solemnity
    case feast
    case memorial
    case optionalMemorial
    case saint
    case personal
}

struct LiturgicalEvent: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let title: String
    let description: String
    let type: LiturgicalEventType
}
