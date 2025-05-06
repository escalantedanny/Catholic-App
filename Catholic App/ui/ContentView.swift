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

                Image("rosario_image")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 250)
                    .clipped()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(Constants.keys.list, id: \.0) { item in
                            Button(action: {
                                print("Botón \(item.0) presionado")
                            }) {
                                VStack {
                                    Image(systemName: item.1)
                                        .resizable()
                                        .frame(width: 30, height: 30)

                                    Text(item.0)
                                        .font(.caption)
                                }
                                .frame(width: 80, height: 80)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(16)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                .padding()

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
