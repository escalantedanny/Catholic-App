
struct BookResponse: Codable {
    let url_libro: String
    let abreviacion: String
    let testamento: String
    let ctd_chapters: Int
    let ctd_verses: Int
    let chapters: [Chapter]
}

struct Chapter: Codable {
    let chapter: String
    let url_chapter: String
    let ctd_verses: Int
    let verses: [String: String]
}
