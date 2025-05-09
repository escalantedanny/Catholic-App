import SwiftUI
import CacheManager

struct ContentView: View {
    
    @State private var showMenu = false
    @State private var selectedTab: Int = 0
    @State private var viewID = UUID()
    @State private var bookSelected: String = "genesis"
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading) {
                VStack(spacing: 0) {

                    TopBarView(showMenu: $showMenu)
                        .background(Color.gray)

                    contentView(for: selectedTab, bookSelected: bookSelected)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                    BottomBarView(selectedTab: $selectedTab)
                    
                }
                .disabled(showMenu)
                .onAppear() {
                    Task {
                        await viewModel.checkHealth()
                    }
                }

                if showMenu {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                showMenu = false
                            }
                        }
                    if selectedTab == 0 || selectedTab == 3 || selectedTab == 4 {
                        SideMenuView(showMenu: $showMenu, selectedTab: $selectedTab)
                            .transition(.move(edge: .leading))
                            .zIndex(1)
                    } else {
                        MenuList(showMenu: $showMenu, bookSelected: $bookSelected)
                            .transition(.move(edge: .leading))
                            .zIndex(1)
                    }
                }
            }
            .animation(.easeInOut, value: showMenu)
        }
    }
}

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
            Text("Próximamente")
        case 4:
            Text("Próximamente")
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


#Preview {
    ContentView()
}
