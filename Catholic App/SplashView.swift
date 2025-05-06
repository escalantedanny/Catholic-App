import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
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

#Preview {
    SplashView()
}
