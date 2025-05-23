import SwiftUI
import CacheManager

struct SideMenuView: View {

    @Binding var showMenu: Bool
    @Binding var selectedTab: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button(action: {
                withAnimation {
                    showMenu = false
                    selectedTab = 0
                }
            }) {
                Label(Constants.Titles.home, systemImage: Constants.Icons.home)
                    .foregroundColor(.black)
            }
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: 250)
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuList: View {
    
    @Binding var showMenu: Bool
    @Binding var bookSelected: String
    @State private var text: String = ""
    
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if !viewModel.books.isEmpty {
                    HStack {
                        TextField("Libro", text: $text)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .submitLabel(.search)
                            .onSubmit {
                                //triggerSearch()
                            }
                        
                        Image(systemName: "magnifyingglass")
                            .padding(.trailing)
                            .onTapGesture {
                                //triggerSearch()
                            }
                    }

                    ForEach(filteredBooks, id: \.self) { libro in
                        let bookName = libro.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        if bookName.lowercased() == "mateo" {
                            ExtractedView(text: "Nuevo Testamento")
                        } else if bookName.lowercased() == "genesis" {
                            ExtractedView(text: "Antiguo Testamento")
                        }
                        Label(bookName, systemImage: "book")
                            .onTapGesture {
                                print("📘 Libro seleccionado: \(libro)")
                                withAnimation {
                                    showMenu = false
                                }
                                bookSelected = libro
                            }
                        
                        if bookName.lowercased() == "apocalipsis" {
                            Spacer()
                        }
                    }
                } else {
                    Text("Cargando libros...").padding()
                }
            }
            .padding(.top, 60)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemBackground))
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
    private var filteredBooks: [String] {
        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            return viewModel.books
        } else {
            return viewModel.books.filter {
                $0.lowercased().contains(text.lowercased())
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
                    gradient: Gradient(colors: [Color.blue, Color.gray]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(height: 1)
                .padding(.vertical, 2)
        }
    }
}


#Preview {
    MenuList(showMenu: .constant(true), bookSelected: .constant("") )
        .environment(\.colorScheme, .dark)

    //SideMenuView(showMenu: .constant(true), selectedTab: .constant(0))
        //.environment(\.colorScheme, .dark)
}
