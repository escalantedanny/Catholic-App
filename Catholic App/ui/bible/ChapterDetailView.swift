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
                    ForEach(sortedVerses, id: \.key) { key, verse in
                        let isLast = key == sortedVerses.last?.key
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

                        if isLast {
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

                                        Button {
                                            navigationPath.removeLast(navigationPath.count)
                                            navigationPath.append(ChapterNavigation(book: nav.book, chapter: afterChapter))
                                        } label: {
                                            Text("next_chapter")
                                                .font(.caption)
                                                .foregroundColor(.blue)
                                                .padding()
                                                .background(Color.blue.opacity(0.05))
                                                .cornerRadius(16)
                                        }
                                    }
                                    .padding(.horizontal)

                                    Text("end_chapter")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                        .padding(.bottom, 8)
                                }
                                .padding(.top, 16)
                            }
                        }
                    }
                }
                .listStyle(.plain)

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
        .background(viewModel.isFavorite(versiculo) ? Color.blue.opacity(0.3) : Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.primary.opacity(0.1), radius: 2)
        .swipeActions(edge: .trailing) {
            if viewModel.isFavorite(versiculo) {
                Button(role: .destructive) {
                    Task {
                        viewModel.deleteFavorite(versiculo: versiculo)
                        await viewModel.fetchDetailBook(libro: versiculo.libro, chapter: Int(versiculo.capitulo)!)
                    }
                } label: {
                    Label("Eliminar de Favoritos", systemImage: "minus.circle.fill")
                }
            } else {
                Button {
                    Task {
                        viewModel.saveFavoriteVersicle(versiculo: versiculo)
                        await viewModel.fetchDetailBook(libro: versiculo.libro, chapter: Int(versiculo.capitulo)!)
                    }
                } label: {
                    Label("Agregar a Favoritos", systemImage: "star.fill")
                }
            }
        }
        .swipeActions(edge: .leading) {
            if viewModel.isFavorite(versiculo) {
                Button(role: .destructive) {
                    Task {
                        viewModel.deleteFavorite(versiculo: versiculo)
                        await viewModel.fetchDetailBook(libro: versiculo.libro, chapter: Int(versiculo.capitulo)!)
                    }
                } label: {
                    Label("Eliminar de Favoritos", systemImage: "minus.circle.fill")
                }
            } else {
                Button {
                    Task {
                        viewModel.saveFavoriteVersicle(versiculo: versiculo)
                        await viewModel.fetchDetailBook(libro: versiculo.libro, chapter: Int(versiculo.capitulo)!)
                    }
                } label: {
                    Label("Agregar a Favoritos", systemImage: "star.fill")
                }
            }
        }
        .contextMenu {
            if viewModel.isFavorite(versiculo) {
                Button {
                    Task {
                        viewModel.deleteFavorite(versiculo: versiculo)
                        await viewModel.fetchDetailBook(libro: versiculo.libro, chapter: Int(versiculo.capitulo)!)
                    }
                } label: {
                    Label("drop_favorite", systemImage: "minus.circle.fill")
                }
            } else {
                Button {
                    Task {
                        viewModel.saveFavoriteVersicle(versiculo: versiculo)
                        await viewModel.fetchDetailBook(libro: versiculo.libro, chapter: Int(versiculo.capitulo)!)
                    }
                } label: {
                    Label("add_favorite", systemImage: "star.fill")
                }
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
                    rootVC.present(activityVC, animated: true, completion: nil)
                }
            } label: {
                Label("share_verse", systemImage: "square.and.arrow.up")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChapterDetailView(
            navigationPath: .constant(NavigationPath()),
            nav: ChapterNavigation(book: "juan", chapter: 15)
        )
    }
}
