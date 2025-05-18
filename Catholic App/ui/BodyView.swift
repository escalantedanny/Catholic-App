import SwiftUI
import CacheManager

struct ShowBodyView: View {
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())
    @State private var navigateToFavorites = false
    @State private var navigateToChapter = false
    @State private var selectedChapter: Int?
    @State private var selectedBook: String?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 6) {
                    
                    Image("rosario_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 250)
                        .clipped()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack() {
                            ForEach(Constants.keys.list, id: \.0) { item in
                                Button(action: {
                                    print("Botón \(item.0) presionado")
                                    if item.0 == "Favoritos" {
                                        navigateToFavorites = true
                                    }
                                }) {
                                    VStack {
                                        Text(item.1)
                                            .font(.system(size: 48))
                                        Text(item.0)
                                            .font(.caption)
                                            .foregroundColor(.primary )
                                    }
                                    .frame(width: 120, height: 120)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(25)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                    .background(Color(.systemBackground))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .navigationDestination(isPresented: $navigateToFavorites) {
                        FavoriteVersesView()
                    }
                    
                    if let versiculo = viewModel.versiculo {
                            VStack {
                                Text(versiculo.texto)
                                    .font(.system(.callout, design: .rounded))
                                    .padding(.horizontal)
                                    .padding(.top)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .bold()

                                Text("\(versiculo.libro.localizedUppercase) \(versiculo.capitulo), \(versiculo.versiculo)")
                                    .font(.system(.caption, design: .rounded))
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                    .padding(.top, 4)
                                    .padding(.bottom, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .bold()
                                
                                NavigationLink(
                                    destination: selectedBook.flatMap { book in
                                        selectedChapter.map { chapter in
                                            ChapterDetailView(libro: book, chapter: chapter)
                                        }
                                    },
                                    isActive: $navigateToChapter,
                                    label: { EmptyView() }
                                )
                                .hidden()
                                
                            }
                            .frame(alignment: .leading)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(25)
                            .padding(.horizontal)
                            .padding(.bottom, 16)
                            .contextMenu {
                                Button {
                                    selectedChapter = Int(versiculo.capitulo)
                                    selectedBook = versiculo.libro
                                    navigateToChapter = true
                                } label: {
                                    Label("Ir al capitulo", systemImage: "arrowshape.turn.up.right.fill")
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
                            .background(Color(.systemBackground))
                    } else {
                        Text("Cargando...!")
                            .padding()
                    }
                    
                    VStack() {
                        HStack() {
                            NavigationLink(destination: TipsView()) {
                                MenuItem(icon: Constants.Icons.tips, title: Constants.labels.Tip)
                            }
                            .foregroundColor(.primary)
                            NavigationLink(destination: RosarioView()) {
                                MenuItem(icon: Constants.Icons.rosario, title: Constants.labels.Rosary)
                            }
                            .foregroundColor(.primary)
                        }
                        
                        HStack() {
                            NavigationLink(destination: LetaniasView()) {
                                MenuItem(icon: Constants.Icons.letanias, title: Constants.labels.Letanies)
                            }
                            .foregroundColor(.primary)
                            NavigationLink(destination: HowToPrayView()) {
                                MenuItem(icon: Constants.Icons.howPray, title: Constants.labels.HowPray)
                            }
                            .foregroundColor(.primary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .cornerRadius(16)
                    .background(Color(.systemBackground))
                }
                .onAppear {
                    Task {
                        await viewModel.fetchRandomVersicle()
                    }
                }
            }
        }
    }
}

struct MenuItem: View {
    let icon: String
    let title: String

    var body: some View {
        VStack {
            if icon.unicodeScalars.first?.properties.isEmojiPresentation == true {
                Text(icon)
                    .font(.system(size: 50))
            } else {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            Text(title)
                .font(.caption)
        }
        .frame(width: 160, height: 80, alignment: .center)
        .background(Color.blue.opacity(0.2))
        .cornerRadius(16)
        .background(Color(.systemBackground))
    }
}

#Preview {
    ShowBodyView()
        //.environment(\.colorScheme, .dark)

}
