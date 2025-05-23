import SwiftUI
import CacheManager

struct ShowBodyView: View {
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())
    @State private var navigateToFavorites = false
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack(alignment: .leading, spacing: 6) {
                    
                    GeometryReader { geometry in
                        let yOffset = geometry.frame(in: .global).minY
                        Image("rosario_image")
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: UIScreen.main.bounds.width,
                                height: yOffset > 0 ? 250 + yOffset : 250
                            )
                            .clipped()
                            .offset(y: yOffset > 0 ? -yOffset : 0)
                    }
                    .frame(height: 250)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack() {
                            ForEach(Constants.keys.menuItems) { item in
                                
                                Button(action: {
                                    navigationPath.append(item.destination)
                                }) {
                                    VStack {
                                        Text(item.emoji)
                                            .font(.system(size: 48))
                                        Text(item.title)
                                            .font(.caption)
                                            .foregroundColor(.primary)
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
                    .navigationDestination(for: MenuDestination.self) { destination in
                        switch destination {
                            case .favorites:
                                FavoriteVersesView()
                            case .tools:
                                FavoriteVersesView()
                            case .games:
                                FavoriteVersesView()
                            case .resources:
                                FavoriteVersesView()
                            case .functions:
                                FavoriteVersesView()
                            case .community:
                                FavoriteVersesView()
                        }
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
                                
                            }
                            .frame(alignment: .leading)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(25)
                            .padding(.horizontal)
                            .padding(.bottom, 16)
                            .contextMenu {
                                Button {
                                    if let chapter = Int(versiculo.capitulo) {
                                        navigationPath.append(ChapterNavigation(book: versiculo.libro, chapter: chapter))
                                    }
                                } label: {
                                    Label("Ir al capitulo", systemImage: "arrowshape.turn.up.right.fill")
                                }
                                Button {
                                    let textoCompleto = "\(versiculo.texto) — \(versiculo.libro.uppercased()) \(versiculo.capitulo), \(versiculo.versiculo)"
                                    UIPasteboard.general.string = textoCompleto
                                } label: {
                                    Label("Copiar versículo", systemImage: "doc.on.doc")
                                }
                                Button {
                                    let textoCompartir = "\(versiculo.texto) — \(versiculo.libro.uppercased()) \(versiculo.capitulo), \(versiculo.versiculo)"
                                    let activityVC = UIActivityViewController(activityItems: [textoCompartir], applicationActivities: nil)
                                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                       let rootVC = windowScene.windows.first?.rootViewController {
                                        rootVC.present(activityVC, animated: true, completion: nil)
                                    }
                                } label: {
                                    Label("Compartir", systemImage: "square.and.arrow.up")
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
                            .navigationDestination(for: ChapterNavigation.self) { destination in
                                ChapterDetailView(
                                    navigationPath: $navigationPath,
                                    nav: destination
                                )
                            }
                            .background(Color(.systemBackground))

                    } else {
                        Text("Cargando...!")
                            .padding()
                    }
                    

                    
                    VStack() {
                        HStack() {
                            Button {
                                navigationPath.append(MenuDestinationBottom.tips)
                            } label: {
                                MenuItem(icon: Constants.Icons.tips, title: "title_tip")
                                    .foregroundColor(.primary)
                            }
                            Button{
                                navigationPath.append(MenuDestinationBottom.rosary)
                            } label: {
                                MenuItem(icon: Constants.Icons.rosario, title: "title_rosary")
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        HStack() {
                            Button {
                                navigationPath.append(MenuDestinationBottom.letanies)
                            } label: {
                                MenuItem(icon: Constants.Icons.letanias, title: "title_letanies")
                                    .foregroundColor(.primary)
                            }
                            Button {
                                navigationPath.append(MenuDestinationBottom.prays)
                            } label : {
                                MenuItem(icon: Constants.Icons.howPray, title: "title_howPray")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .cornerRadius(16)
                    .background(Color(.systemBackground))
                }
                .navigationDestination(for: MenuDestinationBottom.self){ destination in
                    switch destination {
                        case .tips: TipsView()
                        case .rosary: RosarioView()
                        case .letanies: LetaniasView()
                        case .prays: HowToPrayView()
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.fetchRandomVersicle()
                    }
                }
            }
            .refreshable {
                Task {
                    await viewModel.fetchRandomVersicle()
                }
            }
        }

    }
}

struct MenuItem: View {
    let icon: String
    let title: LocalizedStringKey

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
