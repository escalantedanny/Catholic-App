import SwiftUI
import CacheManager
import Resolver

struct SearchingBibleView: View {
    
    @State private var text: String = ""
    @StateObject private var viewModel: BibleApiViewModel = Resolver.resolve()
    @State private var isLoading = false
    @State private var navigateToChapter = false
    @State private var selectedChapter: Int?
    @State private var selectedBook: String?
    
    let popularSearches = ["Amor", "Fe", "Esperanza", "Lázaro", "María", "Pecado", "Dios"]
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $text, onSearch: triggerSearch)
                    .padding()

                if isLoading {
                    ProgressView(Constants.Titles.searching)
                        .padding()
                    Spacer()
                } else {
                    List {
                        if viewModel.versiculos.isEmpty && text.isEmpty {
                            PopularSearchView(searches: popularSearches, onTap: { search in
                                text = search
                                triggerSearch()
                            })
                        }

                        if !viewModel.versiculos.isEmpty {
                            Section(header: Text("Resultados de \(text)")) {
                                ForEach(viewModel.versiculos, id: \.self) { versiculo in
                                    VersiculoRowView(
                                        versiculo: versiculo,
                                        isFavorite: viewModel.isFavorite(versiculo),
                                        onGoToChapter: {
                                            selectedChapter = Int(versiculo.capitulo)
                                            selectedBook = versiculo.libro
                                            navigateToChapter = true
                                        },
                                        onAddFavorite: {
                                            viewModel.saveFavoriteVersicle(versiculo: versiculo)
                                        },
                                        onRemoveFavorite: {
                                            Task {
                                                await viewModel.deleteFavorite(versiculo: versiculo)
                                            }
                                        }
                                    )
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToChapter) {
                if let book = selectedBook, let chapter = selectedChapter {
                    ChapterDetailView(
                        navigationPath: .constant(NavigationPath()),
                        nav: ChapterNavigation(book: book, chapter: chapter)
                    )
                }
            }
        }
    }
    
    private func triggerSearch() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            viewModel.versiculos.removeAll()
            return
        }
        isLoading = true
        viewModel.versiculos.removeAll()
        Task {
            await viewModel.searchVersicle(query: text)
            isLoading = false
        }
    }
}


struct SearchBar: View {
    @Binding var text: String
    let onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("Buscar en la Biblia", text: $text)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .submitLabel(.search)
                .onSubmit { onSearch() }
            
            Image(systemName: "magnifyingglass")
                .padding(.trailing)
                .onTapGesture { onSearch() }
        }
    }
}

struct PopularSearchView: View {
    let searches: [String]
    let onTap: (String) -> Void

    var body: some View {
        Section(header: Text("Búsquedas populares")) {
            ForEach(searches, id: \.self) { search in
                Text(search)
                    .padding()
                    .onTapGesture {
                        onTap(search)
                    }
            }
        }
    }
}

struct VersiculoRowView: View {
    let versiculo: Versiculo
    let isFavorite: Bool
    let onGoToChapter: () -> Void
    let onAddFavorite: () -> Void
    let onRemoveFavorite: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(versiculo.texto)
                .font(.body)
            Text("\(versiculo.libro) \(versiculo.capitulo):\(versiculo.versiculo)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
        .contextMenu {
            Button(action: onGoToChapter) {
                Label("Ir al capítulo", systemImage: "arrowshape.turn.up.right.fill")
            }
            if isFavorite {
                Button(action: onRemoveFavorite) {
                    Label("Eliminar de Favoritos", systemImage: "minus.circle.fill")
                }
            } else {
                Button(action: onAddFavorite) {
                    Label("Agregar a Favoritos", systemImage: "star.fill")
                }
            }
        }
    }
}

#Preview {
    SearchingBibleView()
        //.environment(\.colorScheme, .dark)
}
