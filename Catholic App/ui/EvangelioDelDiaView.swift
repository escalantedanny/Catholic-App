import SwiftUI
import CacheManager

struct EvangelioDelDiaView: View {
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if let evangelio = viewModel.evangelio {
                    SeccionEvangelio(titulo: "📖 Primera Lectura", contenido: evangelio.liturgiaDeLaPalabra)

                    // Procesar el salmo
                    let contenido = evangelio.salmo
                    if let indiceLectura = contenido.firstIndex(where: { $0.uppercased().contains("SEGUNDA LECTURA") }) {
                        let salmo = Array(contenido[..<indiceLectura])
                        let segundaLectura = Array(contenido[indiceLectura...])

                        if !salmo.isEmpty {
                            SeccionEvangelio(titulo: "🎶 Salmo Responsorial", contenido: cutBefore(palabra: "ACLAMACIÓN", en: salmo))
                        }

                        if !segundaLectura.isEmpty {
                            SeccionEvangelio(titulo: "📖 Segunda Lectura", contenido: cutBefore(palabra: "ACLAMACIÓN", en: segundaLectura))
                        }
                    } else if !contenido.isEmpty {
                        SeccionEvangelio(titulo: "🎶 Salmo Responsorial", contenido: cutBefore(palabra: "ACLAMACIÓN", en: contenido))
                    }

                    SeccionEvangelio(titulo: "📜 Evangelio", contenido: cutBefore(palabra: "Credo", en: evangelio.evangelio))
                } else {
                    ProgressView("Cargando evangelio del día...")
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
        if let index = texto.firstIndex(where: { $0.contains(palabra ?? "ACLAMACIÓN") }) {
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
            Text(titulo)
                .font(.title3)
                .bold()
                .foregroundColor(.accentColor)
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
