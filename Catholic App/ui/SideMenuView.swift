import SwiftUI
import CacheManager

struct SideMenuView: View {

    @Binding var showMenu: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label(Constants.Titles.home, systemImage: Constants.Icons.home)
            Label(Constants.Titles.settings, systemImage: Constants.Icons.gear)
            Label(Constants.Titles.closeCession, systemImage: Constants.Icons.arrowBackward)
                .onTapGesture {
                    withAnimation {
                        showMenu = false
                    }
                }

            Spacer()
        }
        .padding(.top, 60)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading) // ⬅ Anclado a la izquierda
        .frame(width: 250)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuList: View {
    
    @Binding var showMenu: Bool
    @Binding var bookSelected: String
    
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if !viewModel.books.isEmpty {
                    ForEach(viewModel.books, id: \.self) { libro in
                        let bookName = libro.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        if bookName.lowercased() == "mateo" {
                            ExtractedView(text: "Nuevo Testamento")
                        } else if bookName.lowercased() == "genesis" {
                            ExtractedView(text: "Antiguo Testamento")
                        }
                        Label(bookName.capitalized, systemImage: "book")
                            .onTapGesture {
                                print("📘 Libro seleccionado: \(libro)")
                                withAnimation {
                                    showMenu = false
                                }
                                bookSelected = libro
                            }
                    }
                } else {
                    Text("Cargando libros...").padding()
                }
            }
            .padding(.top, 60)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 250)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            Task {
                await viewModel.fetchLibros()
            }
        }
    }
}

struct ExtractedView: View {
    let text: String
    
    var body: some View {
        VStack {
            Text(text)
                .bold()
            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(height: 5)
                .padding(.vertical, 4)
        }
    }
}


#Preview {
    MenuList(showMenu: .constant(true), bookSelected: .constant("") )
}
