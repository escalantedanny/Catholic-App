import SwiftUI
import Resolver

@main
struct Catholic_AppApp: App {
    
    init() {
        DependencyRegistration.registerAllServices()
    }

    @StateObject var healthviewModel: CheckHealthModel = Resolver.resolve()
    @State private var isCheckingHealth = true

    var body: some Scene {
        WindowGroup {
            if isCheckingHealth {
                SplashView()
                    .task {
                        await healthviewModel.check()
                        withAnimation {
                            isCheckingHealth = false
                        }
                    }
            } else {
                ContentView()
            }
        }
    }
}

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(red: 254/255, green: 250/255, blue: 246/255).ignoresSafeArea()
            VStack {
                Image("SplashImage")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
            }
        }
    }
}
#Preview {
    SplashView()
}
