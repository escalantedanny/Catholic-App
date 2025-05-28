import SwiftUI
import Resolver

@main
struct Catholic_AppApp: App {
    
    
    init() {
        DependencyRegistration.registerAllServices()
    }
    
    @StateObject var healthviewModel: CheckHealthModel = Resolver.resolve()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Task {
                        await healthviewModel.check()
                    }
                }
        }
    }
}
