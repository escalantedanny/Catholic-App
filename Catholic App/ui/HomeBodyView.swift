import SwiftUI
struct HomeBodyView: View {
    @StateObject private var viewModel = VersiculoViewModel()

    var body: some View {
        VStack {
            if let versiculo = viewModel.versiculo {
                Text("\(versiculo.libro) \(versiculo.capitulo), \(versiculo.versiculo)")
                    .padding()
                Text("\(versiculo.texto)")
                    .fontWeight(.bold)
            } else {
                Text("Salmos 18, 29")
                    .padding()
                Text("Tú eres, Yahveh, mi lámpara, mi Dios que alumbra mis tinieblas")
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    HomeBodyView()
}

