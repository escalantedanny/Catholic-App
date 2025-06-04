import SwiftUI
import CacheManager
import Resolver

struct DetailBookChaptersView: View {
    
    let bookSelected: String
    @State private var navigationPath = NavigationPath()
    @State private var selectedChapter: Int? = nil
    @State private var navigate = false
    @StateObject private var viewModel: BibleApiViewModel = Resolver.resolve()
    private let columns = Array(repeating: GridItem(.flexible()), count: 4)

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
                            LazyVGrid(columns: columns, spacing: 12) {
                                ForEach(1...book.ctd_chapters, id: \.self) { chapter in
                                    Button {
                                        withAnimation {
                                            navigationPath.removeLast(navigationPath.count)
                                            navigationPath.append(ChapterNavigation(book: bookSelected, chapter: chapter))
                                        }
                                    } label: {
                                        ChapterButtonLabel(chapter: chapter)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top)
                        }
                    }
                }
            }
            .padding(.top)
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
        DetailBookChaptersView(bookSelected: "genesis")
    }
    //.environment(\.colorScheme, .dark)
}


struct ChapterButtonLabel: View {
    let chapter: Int

    var body: some View {
        Text("\(chapter)")
            .font(.system(.title2, design: .rounded))
            .frame(maxWidth: .infinity, minHeight: 70)
            .background(Color.blue.opacity(0.5))
            .foregroundColor(.primary)
            .cornerRadius(8)
            .bold()
    }
}
