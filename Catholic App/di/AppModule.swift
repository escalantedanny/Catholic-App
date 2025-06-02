import Foundation
import Resolver
import CacheManager

struct DependencyRegistration {
    static func registerAllServices() {
        Resolver.registerSingletons()
        Resolver.registerViewModels()
    }
}

extension Resolver {
    
    static func registerSingletons() {
        register { CacheManager() }.scope(.application)
        register { CacheManager() as CacheService }.scope(.application)
        register { HealthServiceImpl() as IHealthService }.scope(.application)
        register { ToolsServiceImpl(cache: resolve()) as IToolsService }.scope(.application)
        register { BibleServiceImpl(cache: resolve()) as IBibleService }.scope(.application)
    }
    
    static func registerViewModels() {
        register { CheckHealthModel(healthService: resolve()) }
        register { BibleApiViewModel(bibleService: resolve()) }
        register { ToolsViewModel(toolsService: resolve()) }

    }
}
