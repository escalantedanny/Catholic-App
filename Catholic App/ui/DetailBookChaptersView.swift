import SwiftUI
import CacheManager

struct DetailBookChaptersView: View {
    
    let bookSelected: String
    @State private var navigationPath = NavigationPath()
    @State private var selectedChapter: Int? = nil
    @State private var navigate = false
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                if bookSelected.isEmpty {
                    Text("Selecciona un libro del menú lateral")
                }

                if let book = viewModel.book {
                    VStack {
                        Text("\(bookSelected)")
                            .font(.system(.largeTitle, design: .rounded))
                        ScrollView {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                                ForEach(1...book.ctd_chapters, id: \.self) { chapter in
                                    Button {
                                        navigationPath.removeLast(navigationPath.count)
                                        navigationPath.append(ChapterNavigation(book: bookSelected, chapter: chapter))
                                    } label: {
                                        ChapterButtonLabel(chapter: chapter)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .task(id: bookSelected) {
                await viewModel.fetchLibro(libro: bookSelected)
            }
            .navigationDestination(for: ChapterNavigation.self) { destination in
                ChapterDetailView(
                    navigationPath: $navigationPath,
                    nav: destination
                )
            }
        }
    }
}


#Preview {
    NavigationStack {
        DetailBookChaptersView(bookSelected: "II reyes")
    }
    //.environment(\.colorScheme, .dark)
}


struct ChapterButtonLabel: View {
    let chapter: Int

    var body: some View {
        Text("\(chapter)")
            .font(.system(.caption, design: .rounded))
            .frame(maxWidth: .infinity, minHeight: 44)
            .background(Color(.tertiarySystemFill))
            .foregroundColor(.primary)
            .cornerRadius(8)
            .bold()
    }
}
