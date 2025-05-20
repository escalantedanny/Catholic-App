import Foundation

enum MenuDestination: Hashable {
    case favorites
    case tools
    case games
    case resources
    case functions
    case community
}

enum MenuDestinationBottom: Hashable {
    case tips
    case prays
    case rosary
    case letanies
}

struct MenuItemModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let emoji: String
    let destination: MenuDestination
}
