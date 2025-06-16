import SwiftUI
import CacheManager
import Resolver

struct ShowBodyView: View {
    @StateObject private var viewModel: BibleApiViewModel = Resolver.resolve()
    @State private var navigateToFavorites = false
    @State private var navigationPath = NavigationPath()
    @State private var isFavoriteLocal: Bool = false

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
                        HStack {
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
                    .frame(maxWidth: .infinity)
                    .padding()
                    .navigationDestination(for: MenuDestination.self) { destination in
                        switch destination {
                            case .favorites: FavoriteVersesView()
                            case .tools: SpiritualToolsView()
                            case .games: TriviaView()
                            case .resources: ResourcesView()
                            case .community: CommunityConnectionView()
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

                            HStack {
                                Text("\(versiculo.libro.localizedUppercase) \(versiculo.capitulo), \(versiculo.versiculo)")
                                    .font(.system(.caption, design: .rounded))
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                    .padding(.top, 4)
                                    .padding(.bottom, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .bold()

                                Spacer()

                                MiddleActionsView(
                                    versiculo: versiculo,
                                    isFavoriteLocal: $isFavoriteLocal,
                                    navigationPath: $navigationPath,
                                    viewModel: viewModel
                                )
                            }
                        }
                        .frame(alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(25)
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                        .contextMenu {
                            contextMenuDetail(for: versiculo)
                        }
                        .navigationDestination(for: ChapterNavigation.self) { destination in
                            ChapterDetailView(
                                navigationPath: $navigationPath,
                                nav: destination
                            )
                        }
                        .background(Color(.systemBackground))
                        .onAppear {
                            isFavoriteLocal = viewModel.isFavorite(versiculo)
                        }
                    } else {
                        Text("charging")
                            .padding()
                    }

                    VStack {
                        HStack {
                            Button {
                                navigationPath.append(MenuDestinationBottom.tips)
                            } label: {
                                MenuItem(icon: Constants.Icons.tips, title: "title_tip")
                                    .foregroundColor(.primary)
                            }

                            Button {
                                navigationPath.append(MenuDestinationBottom.rosary)
                            } label: {
                                MenuItem(icon: Constants.Icons.rosario, title: "title_rosary")
                                    .foregroundColor(.primary)
                            }
                        }

                        HStack {
                            Button {
                                navigationPath.append(MenuDestinationBottom.letanies)
                            } label: {
                                MenuItem(icon: Constants.Icons.letanias, title: "title_letanies")
                                    .foregroundColor(.primary)
                            }

                            Button {
                                navigationPath.append(MenuDestinationBottom.prays)
                            } label: {
                                MenuItem(icon: Constants.Icons.howPray, title: "title_howPray")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .cornerRadius(16)
                    .background(Color(.systemBackground))
                }
                .navigationDestination(for: MenuDestinationBottom.self) { destination in
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

    @ViewBuilder
    private func contextMenuDetail(for versiculo: Versiculo) -> some View {
        Button {
            if let chapter = Int(versiculo.capitulo) {
                navigationPath.append(ChapterNavigation(book: versiculo.libro, chapter: chapter))
            }
        } label: {
            Label("go_chapter", systemImage: "arrowshape.turn.up.right.fill")
        }

        Button {
            let textoCompleto = "\(versiculo.texto) — \(versiculo.libro.uppercased()) \(versiculo.capitulo), \(versiculo.versiculo)"
            UIPasteboard.general.string = textoCompleto
        } label: {
            Label("copy_verse", systemImage: "doc.on.doc")
        }

        Button {
            let textoCompartir = "\(versiculo.texto) — \(versiculo.libro.uppercased()) \(versiculo.capitulo), \(versiculo.versiculo)"
            let activityVC = UIActivityViewController(activityItems: [textoCompartir], applicationActivities: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(activityVC, animated: true)
            }
        } label: {
            Label("share_verse", systemImage: "square.and.arrow.up")
        }

        if viewModel.isFavorite(versiculo) {
            Button {
                viewModel.deleteFavorite(versiculo: versiculo)
            } label: {
                Label("drop_favorite", systemImage: "minus.circle.fill")
            }
        } else {
            Button {
                viewModel.saveFavoriteVersicle(versiculo: versiculo)
            } label: {
                Label("add_favorite", systemImage: "star.fill")
            }
        }
    }
}

struct MiddleActionsView: View {
    let versiculo: Versiculo
    @Binding var isFavoriteLocal: Bool
    @Binding var navigationPath: NavigationPath
    let viewModel: BibleApiViewModel

    var body: some View {
        HStack(spacing: 12) {
            Button {
                let textoCompleto = "\(versiculo.texto) — \(versiculo.libro.uppercased()) \(versiculo.capitulo), \(versiculo.versiculo)"
                UIPasteboard.general.string = textoCompleto
            } label: {
                Label("", systemImage: "doc.on.doc")
            }

            Button {
                Task {
                    if isFavoriteLocal {
                        viewModel.deleteFavorite(versiculo: versiculo)
                        isFavoriteLocal = false
                    } else {
                        viewModel.saveFavoriteVersicle(versiculo: versiculo)
                        isFavoriteLocal = true
                    }
                }
            } label: {
                Label("", systemImage: isFavoriteLocal ? "star.fill" : "star")
                    .foregroundColor(Color.blue)
            }

            Button {
                if let chapter = Int(versiculo.capitulo) {
                    navigationPath.append(ChapterNavigation(book: versiculo.libro, chapter: chapter))
                }
            } label: {
                Label("", systemImage: "arrowshape.turn.up.right.fill")
                    .foregroundColor(Color.blue)
            }

            Button {
                let textoCompartir = "\(versiculo.texto) — \(versiculo.libro.uppercased()) \(versiculo.capitulo), \(versiculo.versiculo)"
                let activityVC = UIActivityViewController(activityItems: [textoCompartir], applicationActivities: nil)
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootVC = windowScene.windows.first?.rootViewController {
                    rootVC.present(activityVC, animated: true)
                }
            } label: {
                Label("", systemImage: "square.and.arrow.up")
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
        .frame(width: 175, height: 80)
        .background(Color.blue.opacity(0.2))
        .cornerRadius(16)
        .background(Color(.systemBackground))
    }
}


#Preview {
    ShowBodyView()
}

