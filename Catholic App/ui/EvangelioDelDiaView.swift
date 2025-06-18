import SwiftUI
import CacheManager
import Resolver

struct EvangelioDelDiaView: View {
    @StateObject private var viewModel: BibleApiViewModel = Resolver.resolve()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if let evangelio = viewModel.evangelio {
                    
                    Text(viewModel.liturgiaTitle)
                        .font(.title3)
                        .bold()
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.accentColor)
                        .padding(.vertical, 14)
                    
                    SeccionEvangelio(titulo: "first_reading", contenido: evangelio.liturgiaDeLaPalabra)

                    let contenido = evangelio.salmo
                    if let indiceLectura = contenido.firstIndex(where: { $0.uppercased().contains(Constants.labels.findWord) }) {
                        let salmo = Array(contenido[..<indiceLectura])
                        let segundaLectura = Array(contenido[indiceLectura...])

                        if !salmo.isEmpty {
                            SeccionEvangelio(titulo: "psalm_title", contenido: cutBefore(palabra: Constants.labels.curWord, en: salmo))
                        }

                        if !segundaLectura.isEmpty {
                            SeccionEvangelio(titulo: "second_reading", contenido: cutBefore(palabra: Constants.labels.curWord, en: segundaLectura))
                        }
                    } else if !contenido.isEmpty {
                        SeccionEvangelio(titulo: "psalm_title", contenido: cutBefore(palabra: Constants.labels.curWord, en: contenido))
                    }

                    SeccionEvangelio(titulo: "gospel_title", contenido: cutBefore(palabra: Constants.labels.creedWord, en: evangelio.evangelio))
                } else {
                    ProgressView("charging")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
        }
        .onAppear {
            Task {
                await viewModel.fetchEvangelioDelDia()
            }
        }
    }
    func cutBefore(palabra: String?, en texto: [String]) -> [String] {
        if let index = texto.firstIndex(where: { $0.contains(palabra ?? Constants.labels.curWord) }) {
            return Array(texto[..<index])
        }
        return texto
    }
}

struct SeccionEvangelio: View {
    var titulo: String
    var contenido: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(LocalizedStringKey(titulo))
                .font(.title3)
                .bold()
                .foregroundColor(.black)
                .padding(.vertical, 16)

            ForEach(contenido, id: \.self) { linea in
                Text(linea)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
            }
        }
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 4)
        )
    }
}

#Preview {
    NavigationView {
        EvangelioDelDiaView()
    }
}
