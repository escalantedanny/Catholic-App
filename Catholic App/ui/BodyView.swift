import SwiftUI
import CacheManager

struct ShowBodyView: View {
    
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())
    
    var body: some View {
        VStack(alignment: .leading) {
            if let versiculo = viewModel.versiculo {
                Text("\(versiculo.libro) \(versiculo.capitulo), \(versiculo.versiculo)")
                    .padding()
                Text(versiculo.texto)
                    .fontWeight(.bold)
            } else {
                Text("Cargando...!")
                    .padding()
            }
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.fetchRandomVersicle()
            }
        }
    }
}
