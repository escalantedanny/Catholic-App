import SwiftUI
import CacheManager

struct SearchingBibleView: View {
    
    @State private var text: String = ""
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())
    
    let popularSearches = ["Amor", "Fe", "Esperanza", "Lázaro", "María", "Pecado", "Dios"]
    
    var body: some View {
        VStack {
            HStack {
                TextField("Buscar en la Biblia", text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                Image(systemName: "magnifyingglass")
                    .padding(.trailing)
                    .onTapGesture {
                        viewModel.versiculos.removeAll()
                        Task {
                            await viewModel.searchVersicle(query: text)
                        }
                    }
            }
            .padding()
            
            List {
                if viewModel.versiculos.isEmpty {
                    Section(header: Text("Búsquedas populares")) {
                        ForEach(popularSearches, id: \.self) { search in
                            Text(search)
                                .padding()
                                .onTapGesture {
                                    text = search
                                    viewModel.versiculos.removeAll()
                                    Task {
                                        await viewModel.searchVersicle(query: search)
                                    }
                                }
                        }
                    }
                }
                
                if !viewModel.versiculos.isEmpty {
                    Section(header: Text("Resultados")) {
                        ForEach(viewModel.versiculos, id: \.self) { versiculo in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(versiculo.texto)
                                    .font(.body)
                                Text("\(versiculo.libro) \(versiculo.capitulo):\(versiculo.versiculo)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity)
        }
        .padding()
    }
}

#Preview {
    SearchingBibleView()
}
