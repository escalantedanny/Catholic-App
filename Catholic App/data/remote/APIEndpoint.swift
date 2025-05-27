import Foundation

private let baseURL = URL(string: "https://bible-api-a2sa.onrender.com/libros")

enum APIEndpoint: Endpoint {
    var url: URL {
        return URL(string: self.path, relativeTo: baseURL)!
    }
    
    var path: String {
        switch self {
        case .ping: return "/ping"
        case .randomVersicles: return "/versiculos/aleatorios"
        case .books: return "/"
        case .detailBook(let book, let chapter): return "\(book)/capitulos/\(chapter)"
        case .search: return "/search"
        case .evangelio: return "/evangelio"
        case .book(let book): return "/\(book)"
        }
    }
    
    case ping
    case randomVersicles
    case books
    case book(String)
    case detailBook(String, String)
    case search
    case evangelio

}
