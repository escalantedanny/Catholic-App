import SwiftUI
import CacheManager

struct DetailBookView: View {
    
    let bookSelected: String
    @State private var selectedChapter: Int? = nil
    @State private var navigate = false
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())

    var body: some View {
        VStack {
            if bookSelected.isEmpty {
                Text("Selecciona un libro del menú lateral")
            }

            if let book = viewModel.book {
                NavigationStack {
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                            ForEach(1...book.ctd_chapters, id: \.self) { chapter in
                                Button(action: {
                                    print("Capítulo seleccionado: \(chapter)")
                                    Task {
                                        await viewModel.fetchDetailBook(libro: bookSelected, chapter: chapter)
                                    }
                                }) {
                                    Text("\(chapter)")
                                        .frame(maxWidth: .infinity, minHeight: 44)
                                        .background(Color.blue.opacity(0.2))
                                        .foregroundColor(.black)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .navigationTitle(Text(bookSelected.capitalized))
                        .navigationBarTitleDisplayMode(.automatic)
                    }
                }
            }
        }
        .task(id: bookSelected) {
            await viewModel.fetchLibro(libro: bookSelected)
        }
    }
}

struct ChapterView: View {
    let chapter: ChapterResponse
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Capítulo \(chapter.chapter)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                ForEach(sortedVerses(), id: \.0) { number, text in
                    VStack(alignment: .leading) {
                        Text("\(number). \(text)")
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding(.vertical, 4)
                    }
                }
            }
            .padding()
        }
    }
    
    private func sortedVerses() -> [(String, String)] {
        chapter.verses.sorted { Int($0.key)! < Int($1.key)! }
    }
}

#Preview {
    NavigationStack {
        DetailBookView(bookSelected: "salmos")
    }
}
