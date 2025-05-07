import SwiftUI
import CacheManager

@ViewBuilder
func contentView(for tab: Int, bookSelected: String) -> some View {

    switch tab {
        case 0:
            ShowBodyView()
        case 1:
            SearchingBibleView()
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

struct TopBarView: View {
    @Binding var showMenu: Bool

    var body: some View {
        HStack {
            Text(Constants.Titles.appName)
                .font(.title2)
                .bold()
            Spacer()
            Button(action: {
                withAnimation {
                    showMenu = true
                }
            }) {
                Image(systemName: Constants.Icons.menu)
                    .padding()
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
        .foregroundColor(.white)
    }
}
