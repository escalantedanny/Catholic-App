import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0

        var body: some View {
            VStack(spacing: 0) {
                TopBarView()

                Group {
                    switch selectedTab {
                    case 0:
                        ShowBodyView()
                    case 1:
                        Text("contenido dinámico 1")
                    case 2:
                        Text("contenido dinámico 2")
                    case 3:
                        Text("contenido dinámico 3")
                    case 4:
                        Text("contenido dinámico 4")
                    default:
                        Text("contenido dinámico default")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                BottomBarView(selectedTab: $selectedTab)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
}

struct ShowBodyView: View {
    @StateObject private var viewModel = VersiculoViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            if let versiculo = viewModel.versiculo {
                Text("\(versiculo.libro) \(versiculo.capitulo), \(versiculo.versiculo)")
                    .padding()
                Text(versiculo.texto)
                    .fontWeight(.bold)
            } else {
                Text("Salmos 18, 29")
                    .padding()
                Text("Tú eres, Yahveh, mi lámpara, mi Dios que alumbra mis tinieblas")
                    .fontWeight(.bold)
            }
        }
        .padding()
    }
}



#Preview {
    ContentView()
}
