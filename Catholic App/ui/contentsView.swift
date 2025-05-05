import SwiftUI
import CacheManager

@ViewBuilder
func contentView(for tab: Int, bookSelected: String) -> some View {

    
    switch tab {
    case 0:
        ShowBodyView()
    case 1:
        DetailBookView(bookSelected: bookSelected)
    case 2:
        DetailBookView(bookSelected: bookSelected)
    case 3:
        Text("contenido dinámico 3")
    case 4:
        Text("contenido dinámico 4")
    default:
        ShowBodyView()
    }
}


@ViewBuilder
func topBarView(for tab: Int, showMenu: Binding<Bool>) -> some View {

    switch tab {
    case 0, 3, 4:
        BasicTopBarView(showMenu: showMenu)
    case 1, 2:
        DetailTopBarMenu(showMenu: showMenu)
    default:
        BasicTopBarView(showMenu: showMenu)
    }
}
