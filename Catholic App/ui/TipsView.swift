import SwiftUI

struct TipsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("🙏 Consejos que te ayudarán a orar")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                ForEach(tips, id: \.number) { tip in
                    TipCard(tip: tip)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Consejos de Oración")
    }
}

// MARK: - Modelo
struct PrayerTip {
    let number: Int
    let title: String
    let content: String
    let icon: String
}

// MARK: - Tarjeta visual
struct TipCard: View {
    let tip: PrayerTip

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 12) {
                Text("🔹\(tip.number)")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 4) {
                    Text(tip.title)
                        .font(.headline)
                        .bold()
                    Text(tip.content)
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Datos
let tips: [PrayerTip] = [
    PrayerTip(number: 1, title: "Dialoga con Dios", content: "Orar es dialogar con Dios con confianza. Dios quiere encontrarse contigo. Cree, insiste y ábrete a la comunicación con Él.", icon: "🗣️"),
    PrayerTip(number: 2, title: "Elige un tiempo y lugar", content: "Busca un momento y espacio apropiado para orar, como hacía Jesús. La constancia crea el hábito.", icon: "⏰"),
    PrayerTip(number: 3, title: "No te preocupes por las palabras", content: "Dios conoce tu corazón antes de que hables. No uses muchas palabras; habla con sencillez.", icon: "💬"),
    PrayerTip(number: 4, title: "Sé tú mismo", content: "Habla con Dios como con un amigo cercano. Exprésale tus ideas, emociones, intenciones y escucha lo que Él tiene para decirte.", icon: "🧍"),
    PrayerTip(number: 5, title: "Concéntrate", content: "Desconéctate del mundo exterior. Apaga dispositivos y enfócate en ese momento especial con Dios.", icon: "📴"),
    PrayerTip(number: 6, title: "Sé específico", content: "Evita oraciones vagas. Expresa con claridad tus ideas. Si necesitas, escribe lo que deseas decir.", icon: "✍️"),
    PrayerTip(number: 7, title: "Reflexiona sobre el propósito", content: "Ora para adorar, agradecer, pedir perdón, interceder o pedir. Sé consciente del motivo de tu oración.", icon: "🎯"),
    PrayerTip(number: 8, title: "Ora en comunidad", content: "La oración en grupo es poderosa. Orar con otros fortalece tu fe y tu relación con Dios.", icon: "🤝"),
    PrayerTip(number: 9, title: "Escucha a Dios", content: "Ten paciencia. A veces Dios responde de formas inesperadas. Déjalo actuar a su manera y en su tiempo.", icon: "👂"),
    PrayerTip(number: 10, title: "Usa la Biblia", content: "La Biblia es guía y alimento para la oración. En ella, Dios se hace presente y te habla.", icon: "📖")
]

// MARK: - Vista previa
#Preview {
    NavigationStack {
        TipsView()
            .environment(\.colorScheme, .dark)
    }
}
