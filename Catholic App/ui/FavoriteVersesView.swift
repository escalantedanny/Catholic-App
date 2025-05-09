import SwiftUI
import CacheManager

struct FavoriteVersesView: View {
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())
    @State private var favoritos: [Versiculo] = []

    var body: some View {
        VStack {
            Text("Versículos Favoritos")
                .font(.title)
                .bold()
                .padding()

            if favoritos.isEmpty {
                Text("No hay versículos favoritos aún.")
                    .foregroundColor(.gray)
                    .padding()
                Spacer()
            } else {
                List {
                    ForEach(favoritos, id: \.self) { versiculo in
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
                                viewModel.deleteFavoriteVersicle(versiculo: versiculo)
                                loadFavorites()
                            } label: {
                                Label("Eliminar de Favoritos", systemImage: "star.slash.fill")
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            loadFavorites()
        }
    }

    private func loadFavorites() {
        favoritos = viewModel.getFavoriteVerses()
    }
}

#Preview {
    FavoriteVersesView()
}
