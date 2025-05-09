import SwiftUI
import CacheManager

struct SearchingBibleView: View {
    
    @State private var text: String = ""
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())
    @State private var isLoading = false
    @State private var navigateToChapter = false
    @State private var selectedChapter: Int?
    @State private var selectedBook: String?
    
    let popularSearches = ["Amor", "Fe", "Esperanza", "Lázaro", "María", "Pecado", "Dios"]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Buscar en la Biblia", text: $text)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .submitLabel(.search)
                        .onSubmit {
                            triggerSearch()
                        }
                    
                    Image(systemName: "magnifyingglass")
                        .padding(.trailing)
                        .onTapGesture {
                            triggerSearch()
                        }
                }
                .padding()
                
                if isLoading {
                    ProgressView(Constants.Titles.searching)
                        .padding()
                    Spacer()
                } else {
                    List {
                        if viewModel.versiculos.isEmpty && text.isEmpty {
                            Section(header: Text("Búsquedas populares")) {
                                ForEach(popularSearches, id: \.self) { search in
                                    Text(search)
                                        .padding()
                                        .onTapGesture {
                                            text = search
                                            triggerSearch()
                                        }
                                }
                            }
                        }
                        
                        if !viewModel.versiculos.isEmpty {
                            Section(header: Text("Resultados de \(text)")) {
                                ForEach(viewModel.versiculos, id: \.self) { versiculo in
                                    VStack(alignment: .leading) {
                                        Text(versiculo.texto)
                                            .font(.body)
                                        Text("\(versiculo.libro) \(versiculo.capitulo):\(versiculo.versiculo)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        
                                    }
                                    .padding(.vertical, 4)
                                    .contextMenu {
                                        Button {
                                            selectedChapter = Int(versiculo.capitulo)
                                            selectedBook = versiculo.libro
                                            navigateToChapter = true
                                        } label: {
                                            Label("Ir al capítulo", systemImage: "arrowshape.turn.up.right.fill")
                                        }
                                        if viewModel.isFavorite(versiculo) {
                                            Button {
                                                viewModel.deleteFavoriteVersicle(versiculo: versiculo)
                                            } label: {
                                                Label("Eliminar de Favoritos", systemImage: "minus.circle.fill")
                                            }
                                        } else {
                                            Button {
                                                viewModel.saveFavoriteVersicle(versiculo: versiculo)
                                            } label: {
                                                Label("Agregar a Favoritos", systemImage: "star.fill")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToChapter) {
                if let book = selectedBook, let chapter = selectedChapter {
                    ChapterDetailView(libro: book, chapter: chapter)
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

#Preview {
    SearchingBibleView()
}
