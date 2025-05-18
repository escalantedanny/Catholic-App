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
                    Text("\(bookSelected.capitalized)")
                        .font(.system(.largeTitle, design: .rounded))
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                            ForEach(1...book.ctd_chapters, id: \.self) { chapter in
                                NavigationLink(destination: ChapterDetailView(libro: bookSelected, chapter: chapter)){
                                    Text("\(chapter)")
                                        .font(.system(.title3, design: .rounded))
                                        .frame(maxWidth: .infinity, minHeight: 44)
                                        .background(Color(.tertiarySystemFill))
                                        .foregroundColor(.primary)
                                        .cornerRadius(8)
                                        .bold()
                                }
                            }
                        }
                        .padding(.horizontal, 16)
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

struct ChapterDetailView: View {
    let libro: String
    let chapter: Int
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if let chapterData = viewModel.chapter {
                    VStack {
                        Text(libro.uppercased())
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text(" Capítulo \(chapter)")
                            .font(.caption)
                            .padding(.bottom)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }

                    ForEach(chapterData.verses.sorted(by: { Int($0.key)! < Int($1.key)! }), id: \.key) { key, verse in
                        HStack(alignment: .top) {
                            Text("\(key)")
                                .fontWeight(.bold)
                                .frame(width: 30, alignment: .leading)
                            Text(verse)
                                .multilineTextAlignment(.leading)
                                .bold()
                        }
                        .padding(16)
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color.primary.opacity(0.1), radius: 2)
                        .contextMenu {
                            let versiculo = Versiculo(
                                libro: libro,
                                capitulo: String(chapter),
                                versiculo: key,
                                texto: verse
                            )
                            Button {
                                viewModel.saveFavoriteVersicle(versiculo:versiculo)
                            } label : {
                                HStack {
                                    Text("Agregar a Favoritos")
                                    Image(systemName: "star.fill")
                                }
                            }
                        }
                    }
                } else {
                    ProgressView("Cargando capítulo...")
                }
            }
            .padding()
        }
        .task {
            await viewModel.fetchDetailBook(libro: libro, chapter: chapter)
        }
    }
}

#Preview {
    NavigationStack {
        DetailBookView(bookSelected: "juan")
    }
    //.environment(\.colorScheme, .dark)
}
