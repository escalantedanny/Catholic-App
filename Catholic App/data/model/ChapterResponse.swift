struct ChapterResponse: Decodable {
    let chapter: String
    let url_chapter: String
    let ctd_verses: Int
    let verses: [String: String]
}
