import SwiftUI
import CacheManager

struct ShowBodyView: View {
    
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
        
            if let versiculo = viewModel.versiculo {
                Text("\(versiculo.libro.localizedUppercase) \(versiculo.capitulo), \(versiculo.versiculo)")
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
        Spacer()
    }
}

#Preview {
    ShowBodyView()
}
