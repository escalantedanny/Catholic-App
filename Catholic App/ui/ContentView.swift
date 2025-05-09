import SwiftUI
import CacheManager

struct ContentView: View {
    
    @State private var showMenu = false
    @State private var selectedTab: Int = 0
    @State private var viewID = UUID()
    @State private var bookSelected: String = ""
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(spacing: 0) {
                topBarView(for: selectedTab, showMenu: $showMenu)
                    .background(Color.gray)

                contentView(for: selectedTab, bookSelected: bookSelected)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                BottomBarView(selectedTab: $selectedTab)
            }
            .disabled(showMenu)

            if showMenu {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showMenu = false
                        }
                    }
                if selectedTab == 0 || selectedTab == 3 || selectedTab == 4 {
                    SideMenuView(showMenu: $showMenu)
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


#Preview {
    ContentView()
}
