import CacheManager
import Resolver
import SwiftUI

struct DetailBookChaptersView: View {

    let bookSelected: String
    @State private var navigationPath = NavigationPath()
    @State private var selectedBook: String? = nil
    @State private var searchText = ""

    @StateObject private var viewModel: BibleApiViewModel = Resolver.resolve()
    private let columns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                if selectedBook == nil {
                    VStack(spacing: 16) {
                        Text("📖 Explora la Biblia")
                            .font(.title)
                            .bold()

                        Text("Selecciona un libro para comenzar")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        TextField("Buscar libro...", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)

                        List {
                            ForEach(filteredBooks, id: \.self) { book in
                                Button {
                                    selectedBook = book
                                    searchText = ""
                                    Task {
                                        await viewModel.fetchLibro(libro: book)
                                    }
                                } label: {
                                    Text(book)
                                }
                            }
                        }
                    }
                } else if let book = viewModel.book {
                    VStack {
                        HStack {
                            Button("🔙 Cambiar libro") {
                                withAnimation {
                                    selectedBook = nil
                                    viewModel.book = nil
                                    searchText = ""
                                }
                            }
                            .padding(.leading)
                            .font(.title3)
                            .foregroundColor(.black)
                            Spacer()
                        }

                        Text(selectedBook!.capitalized)
                            .font(.system(.largeTitle, design: .rounded))
                            .padding(.top)

                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 12) {
                                ForEach(1...book.ctd_chapters, id: \.self) { chapter in
                                    let isLast = chapter == book.ctd_chapters
                                    Button {
                                        withAnimation {
                                            navigationPath.removeLast(navigationPath.count)
                                            navigationPath.append(
                                                ChapterNavigation(book: selectedBook!, chapter: chapter, isLast: isLast)
                                            )
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
                } else {
                    ProgressView()
                }
            }
            .padding(.top)
            .task {
                await viewModel.fetchLibros()
                if !bookSelected.isEmpty {
                    selectedBook = bookSelected
                    await viewModel.fetchLibro(libro: bookSelected)
                }
            }
            .navigationDestination(for: ChapterNavigation.self) { destination in
                ChapterDetailView(navigationPath: $navigationPath, nav: destination)
            }
        }
    }

    var filteredBooks: [String] {
        if searchText.isEmpty {
            return viewModel.books
        } else {
            return viewModel.books.filter {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    DetailBookChaptersView(bookSelected: "deuteronomio")
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
