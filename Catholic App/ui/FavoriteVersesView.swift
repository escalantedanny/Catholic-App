import SwiftUI
import CacheManager
import Resolver

struct FavoriteVersesView: View {
    @StateObject private var viewModel: BibleApiViewModel = Resolver.resolve()
    @State private var favoritos: [Versiculo]
    private let isPreview: Bool
    
    init(favoritos: [Versiculo] = [], isPreview: Bool = false) {
        _favoritos = State(initialValue: favoritos)
        self.isPreview = isPreview
    }

    var body: some View {
        VStack {
            Text("favorite_verse_title")
                .font(.title)
                .bold()
                .padding()

            if favoritos.isEmpty {
                Text("no_favorites_verse_yet")
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
                                viewModel.deleteFavorite(versiculo: versiculo)
                                loadFavorites()
                            } label: {
                                Label("drop_favorite", systemImage: "star.slash.fill")
                            }
                        }
                    }
                }
            }
        }
        .background(Color(.systemBackground))
        .onAppear {
            if !isPreview {
                loadFavorites()
            }
        }
    }


    private func loadFavorites() {
        self.favoritos = viewModel.getFavoriteVerses()
    }
}

#Preview {
    FavoriteVersesView(
        favoritos: [
            Versiculo(libro: "Romanos", capitulo: "1", versiculo: "1", texto: "En los tiempos de los Reyes Magos")
        ],
        isPreview: true
    )
}
