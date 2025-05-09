import SwiftUI
import CacheManager

struct SearchingBibleView: View {
    
    @State private var text: String = ""
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())
    @State private var isLoading = false
    
    let popularSearches = ["Amor", "Fe", "Esperanza", "Lázaro", "María", "Pecado", "Dios"]
    
    var body: some View {
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
                                    if viewModel.isFavorite(versiculo) {
                                        Button {
                                            viewModel.deleteFavoriteVersicle(versiculo: versiculo)
                                        } label: {
                                            Label("Eliminar de Favoritos", systemImage: "star.slash.fill")
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
                .frame(maxHeight: .infinity)
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
