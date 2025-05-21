import SwiftUI

struct MenuItemModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let emoji: String
    let destination: MenuDestination
}

