import SwiftUI

struct TipsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Consejos que te ayudarán a orar")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 8)

                Group {
                    TipView(title: "1. Dialoga con Dios",
                            content: "Orar es dialogar con Dios con confianza. Dios quiere encontrarse contigo. Cree, insiste y ábrete a la comunicación con Él.")

                    TipView(title: "2. Elige un tiempo y lugar",
                            content: "Busca un momento y espacio apropiado para orar, como hacía Jesús. La constancia crea el hábito.")

                    TipView(title: "3. No te preocupes por las palabras",
                            content: "Dios conoce tu corazón antes de que hables. No uses muchas palabras; habla con sencillez.")

                    TipView(title: "4. Sé tú mismo",
                            content: "Habla con Dios como con un amigo cercano. Exprésale tus ideas, emociones, intenciones y escucha lo que Él tiene para decirte.")

                    TipView(title: "5. Concéntrate",
                            content: "Desconéctate del mundo exterior. Apaga dispositivos y enfócate en ese momento especial con Dios.")

                    TipView(title: "6. Sé específico",
                            content: "Evita oraciones vagas. Expresa con claridad tus ideas. Si necesitas, escribe lo que deseas decir.")

                    TipView(title: "7. Reflexiona sobre el propósito",
                            content: "Ora para adorar, agradecer, pedir perdón, interceder o pedir. Sé consciente del motivo de tu oración.")

                    TipView(title: "8. Ora en comunidad",
                            content: "La oración en grupo es poderosa. Orar con otros fortalece tu fe y tu relación con Dios.")

                    TipView(title: "9. Escucha a Dios",
                            content: "Ten paciencia. A veces Dios responde de formas inesperadas. Déjalo actuar a su manera y en su tiempo.")

                    TipView(title: "10. Usa la Biblia",
                            content: "La Biblia es guía y alimento para la oración. En ella, Dios se hace presente y te habla.")
                }
            }
            .padding()
        }
    }
}

struct TipView: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
            Text(content)
                .font(.body)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    TipsView()
}
