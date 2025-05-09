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


#Preview {
    ContentView()
}
