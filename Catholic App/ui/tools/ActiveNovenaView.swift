import SwiftUI

struct ActiveNovenaView: View {
    @ObservedObject var viewModel: NovenaViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let novena = viewModel.activeNovena,
               let currentPrayer = viewModel.currentPrayer {
                
                Text(novena.title)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)

                Text(currentPrayer.dayTitle)
                    .font(.headline)
                    .foregroundColor(.secondary)

                ScrollView {
                    Text(currentPrayer.prayer)
                        .font(.body)
                        .padding(.top, 8)
                }

                if let finales = novena.oracionesFinales {
                    Divider()
                    Text("Oraciones Finales")
                        .font(.headline)
                    Text(finales)
                        .font(.body)
                        .padding(.top, 4)
                }
            } else {
                Text("No hay una novena activa.")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .navigationTitle("Novena Activa")
    }
}

#Preview {
    let sampleNovena = Novena(
        id: UUID(),
        title: "Novena al Sagrado Corazón",
        prayers: [
            DailyPrayer(id: UUID(), dayTitle: "Día 1", prayer: "Oración del primer día..."),
            DailyPrayer(id: UUID(), dayTitle: "Día 2", prayer: "Oración del segundo día..."),
            DailyPrayer(id: UUID(), dayTitle: "Día 3", prayer: "Oración del tercer día..."),
        ],
        threePadreNuestros: "Oración final de todos los días...",
        oracionesFinales: "Oración final de todos los días..."
    )

    let viewModel = NovenaViewModel()
    viewModel.activeNovena = sampleNovena
    viewModel.startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())

    return NavigationStack {
        ActiveNovenaView(viewModel: viewModel)
    }
}
