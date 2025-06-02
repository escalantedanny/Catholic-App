import SwiftUI
import UserNotifications

struct NovenaSelectorView: View {
    @StateObject private var viewModel = NovenaViewModel()

    var body: some View {
        if let novena = viewModel.activeNovena {
            NavigationLink(destination: NovenaDetailView(viewModel: viewModel)) {
                Text("Continuar novena: \(novena.title)")
                    .padding()
                    .font(.headline)
            }
            .navigationTitle("Mi Novena")
        } else {
            List(viewModel.novenas) { novena in
                NavigationLink(destination: NovenaDetailView(novena: novena, viewModel: viewModel)) {
                    Text(novena.title)
                }
            }
            .navigationTitle("Elige una Novena")
        }
        
    }
}

struct NovenaDetailView: View {
    let novena: Novena?
    @ObservedObject var viewModel: NovenaViewModel

    init(novena: Novena? = nil, viewModel: NovenaViewModel) {
        self.novena = novena
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(viewModel.activeNovena?.title ?? novena?.title ?? "")
                    .font(.title)
                    .bold()

                if let active = viewModel.activeNovena {
                    Text("Iniciada el \(viewModel.startDate?.formatted(date: .long, time: .omitted) ?? "")")
                        .font(.footnote)
                        .foregroundColor(.blue)

                    if let prayer = viewModel.currentPrayer {
                        NovenaDayView(
                            dayTitle: prayer.dayTitle,
                            prayer: prayer.prayer,
                            threePadreNuestros: active.threePadreNuestros ?? "",
                            oracionesFinales: active.oracionesFinales ?? ""
                        )
                    }

                    HStack {
                        Button("Anterior") { viewModel.goToPreviousDay() }
                            .disabled(viewModel.isFirstDay())

                        Spacer()

                        Button("Siguiente") { viewModel.goToNextDay() }
                            .disabled(viewModel.isLastDay())
                    }

                    Button("Cancelar Novena", role: .destructive) {
                        viewModel.resetNovena()
                    }
                    .padding(.top)

                } else if let novena = novena {
                    Button("Iniciar Novena") {
                        requestNotificationPermission {
                            viewModel.startNovena(novena)
                            viewModel.scheduleNovenaNotifications()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                }
            }
            .padding()
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
    }

    func requestNotificationPermission(completion: @escaping () -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            DispatchQueue.main.async {
                granted ? completion() : ()
            }
        }
    }
}

struct NovenaDayView: View {
    let dayTitle: String
    let prayer: String
    let threePadreNuestros: String
    let oracionesFinales: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("📅 \(dayTitle)")
                .font(.headline)

            Text(prayer)
                .font(.body)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)

            if !threePadreNuestros.isEmpty {
                Text(threePadreNuestros)
                    .font(.body)
                    .bold()
                    .padding(.top)
            }

            Divider()

            Text(oracionesFinales)
                .font(.body)
                .padding()
                .background(Color(.tertiarySystemBackground))
                .cornerRadius(12)
        }
    }
}

#Preview {
    NavigationStack {
        NovenaDetailView(
            novena: Novena(
                id: UUID(),
                title: "Sagrado Corazón de Jesús",
                prayers: [
                    DailyPrayer(id: UUID(), dayTitle: "Día 1", prayer: "Oh Corazón de Jesús, fuente inagotable de misericordia, te adoro y te ofrezco mis oraciones."),
                    DailyPrayer(id: UUID(), dayTitle: "Día 2", prayer: "Corazón de Jesús, lleno de amor y compasión, derrama tus gracias sobre nosotros."),
                    DailyPrayer(id: UUID(), dayTitle: "Día 3", prayer: "Corazón de Jesús, llama de amor viva, enciende en mí un fuego de amor por Ti"),
                    DailyPrayer(id: UUID(), dayTitle: "Día 4", prayer: "Corazón de Jesús, refugio de los pecadores, ten piedad de nosotros."),
                    DailyPrayer(id: UUID(), dayTitle: "Día 5", prayer: "Corazón de Jesús, esperanza de los enfermos, consuela a los que sufren."),
                    DailyPrayer(id: UUID(), dayTitle: "Día 6", prayer: "Corazón de Jesús, paz y reconciliación de los corazones, restaura la unidad en nuestras familias."),
                    DailyPrayer(id: UUID(), dayTitle: "Día 7", prayer: "Corazón de Jesús, fortaleza de los humildes, fortalece mi fe y confianza en Ti."),
                    DailyPrayer(id: UUID(), dayTitle: "Día 8", prayer: "Corazón de Jesús, amigo de los niños y los pequeños, protégelos siempre."),
                    DailyPrayer(id: UUID(), dayTitle: "Día 9", prayer: "Corazón de Jesús, reina y soberano de mi vida, recibe mi corazón y hazlo semejante al Tuyo.")
                ],
                threePadreNuestros: "Rezar 3 Padre Nuestros, 3 Avemarías.",
                oracionesFinales: "Oraciones finales para concluir la novena."
            ),
            viewModel: NovenaViewModel()
        )
    }
}
