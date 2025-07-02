import SwiftUI
import CacheManager
import Resolver

struct ChapterDetailView: View {
    @Binding var navigationPath: NavigationPath
    let nav: ChapterNavigation

    @StateObject private var viewModel: BibleApiViewModel = Resolver.resolve()

    var body: some View {
        VStack(alignment: .leading) {
            if let chapterData = viewModel.chapter {
                VStack {
                    Text(nav.book.uppercased())
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Text("Capítulo \(nav.chapter)")
                        .font(.caption)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                let sortedVerses = chapterData.verses.sorted { Int($0.key)! < Int($1.key)! }
                let beforeChapter = nav.chapter - 1
                let afterChapter = nav.chapter + 1

                List {
                    ForEach(sortedVerses, id: \ .key) { key, verse in
                        let versiculo = Versiculo(
                            libro: nav.book,
                            capitulo: String(nav.chapter),
                            versiculo: key,
                            texto: verse
                        )

                        ChapterDataView(
                            versiculo: versiculo,
                            viewModel: viewModel
                        )
                    }
                }
                .listStyle(.plain)

                Section {
                    VStack(spacing: 16) {
                        HStack {
                            if beforeChapter > 0 {
                                Button {
                                    navigationPath.removeLast(navigationPath.count)
                                    navigationPath.append(ChapterNavigation(book: nav.book, chapter: beforeChapter))
                                } label: {
                                    Text("previous_chapter")
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                        .padding()
                                        .background(Color.blue.opacity(0.05))
                                        .cornerRadius(16)
                                }
                            }

                            Spacer(minLength: 32)

                            if !nav.isLast {
                                Button {
                                    navigationPath.removeLast(navigationPath.count)
                                    navigationPath.append(ChapterNavigation(book: nav.book, chapter: afterChapter, isLast: nav.isLast == false))
                                } label: {
                                    Text("next_chapter")
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                        .padding()
                                        .background(Color.blue.opacity(0.05))
                                        .cornerRadius(16)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 16)
                }

            } else {
                ProgressView("charging")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding(.horizontal, 16)
        .task(id: nav.chapter) {
            await viewModel.fetchDetailBook(libro: nav.book, chapter: nav.chapter)
        }
    }
}

struct ChapterDataView: View {
    let versiculo: Versiculo
    let viewModel: BibleApiViewModel
    @State private var isFavorite: Bool = false

    var body: some View {
        HStack(alignment: .top) {
            Text("\(versiculo.versiculo)")
                .fontWeight(.bold)
                .frame(width: 30, alignment: .leading)

            Text(versiculo.texto)
                .multilineTextAlignment(.leading)
                .bold()
        }
        .padding(16)
        .background(isFavorite ? Color.blue.opacity(0.3) : Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.primary.opacity(0.1), radius: 2)
        .onAppear {
            isFavorite = viewModel.isFavorite(versiculo)
        }
        .swipeActions {
            favoriteAction()
        }
        .swipeActions(edge: .leading) {
            favoriteAction()
        }
        .contextMenu {
            favoriteButton()

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
                Label("Compartir versículo", systemImage: "square.and.arrow.up")
            }
        }
    }

    @ViewBuilder
    private func favoriteAction() -> some View {
        Button {
            let textoCompleto = "\(versiculo.texto) — \(versiculo.libro.uppercased()) \(versiculo.capitulo), \(versiculo.versiculo)"
            UIPasteboard.general.string = textoCompleto
        } label: {
            Label("Copiar versículo", systemImage: "doc.on.doc")
        }
        .tint(.gray)
        Button {
            let textoCompartir = "\(versiculo.texto) — \(versiculo.libro.uppercased()) \(versiculo.capitulo), \(versiculo.versiculo)"
            let activityVC = UIActivityViewController(activityItems: [textoCompartir], applicationActivities: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(activityVC, animated: true, completion: nil)
            }
        } label: {
            Label("Compartir versículo", systemImage: "square.and.arrow.up")
        }
        .tint(.blue)
        if isFavorite {
            Button(role: .destructive) {
                Task {
                    viewModel.deleteFavorite(versiculo: versiculo)
                    isFavorite = false
                    await viewModel.fetchDetailBook(libro: versiculo.libro, chapter: Int(versiculo.capitulo)!)
                }
            } label: {
                Label("Eliminar de Favoritos", systemImage: "minus.circle.fill")
            }
            .tint(.red)
        } else {
            Button {
                Task {
                    viewModel.saveFavoriteVersicle(versiculo: versiculo)
                    isFavorite = true
                    await viewModel.fetchDetailBook(libro: versiculo.libro, chapter: Int(versiculo.capitulo)!)
                }
            } label: {
                Label("Agregar a Favoritos", systemImage: "star.fill")
            }
            .tint(.green)
        }
    }

    @ViewBuilder
    private func favoriteButton() -> some View {
        if isFavorite {
            Button {
                Task {
                    viewModel.deleteFavorite(versiculo: versiculo)
                    isFavorite = false
                    await viewModel.fetchDetailBook(libro: versiculo.libro, chapter: Int(versiculo.capitulo)!)
                }
            } label: {
                Label("Eliminar de Favoritos", systemImage: "minus.circle.fill")
            }
        } else {
            Button {
                Task {
                    viewModel.saveFavoriteVersicle(versiculo: versiculo)
                    isFavorite = true
                    await viewModel.fetchDetailBook(libro: versiculo.libro, chapter: Int(versiculo.capitulo)!)
                }
            } label: {
                Label("Agregar a Favoritos", systemImage: "star.fill")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChapterDetailView(
            navigationPath: .constant(NavigationPath()),
            nav: ChapterNavigation(book: "deuteronomio", chapter: 33, isLast: false)
        )
    }
}
