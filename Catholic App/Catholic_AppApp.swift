import SwiftUI

@main
struct Catholic_AppApp: App {
    @State private var isActive = false
    var body: some Scene {
        WindowGroup {
            if isActive {
                ContentView()
            } else {
                ZStack {
                    Color.white
                        .ignoresSafeArea()

                    Image("logo_app")
                        .resizable()
                        .scaledToFit()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}
