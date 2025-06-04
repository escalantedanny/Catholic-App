import Foundation
import Combine
final class LanguageManager: ObservableObject {
    static let shared = LanguageManager()

    @Published var currentLanguage: String = "es-419" {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "selectedLanguage")
            bundle = LanguageManager.getBundle(for: currentLanguage)
        }
    }

    private(set) var bundle: Bundle = LanguageManager.getBundle(for: "es-419")

    init() {
        let savedLang = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "es-419"
        currentLanguage = savedLang
        bundle = LanguageManager.getBundle(for: savedLang)
    }

    static func getBundle(for language: String) -> Bundle {
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            print("⚠️ No se encontró el bundle para: \(language), usando .main")
            return .main
        }
        return bundle
    }

    func localizedString(forKey key: String) -> String {
        bundle.localizedString(forKey: key, value: "**\(key)**", table: nil)
    }
}

extension String {
    func localized(using manager: LanguageManager) -> String {
        manager.localizedString(forKey: self)
    }
}
