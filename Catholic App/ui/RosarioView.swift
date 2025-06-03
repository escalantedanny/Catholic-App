import SwiftUI

struct RosarioView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                Text("🕊️ Rosario")
                    .font(.largeTitle)
                    .bold()

                Text("Este Rosario se reza en comunidad, acompañando a María en la contemplación de la vida de su Hijo. Abre tu corazón y deja que el Espíritu Santo te guíe.")
                    .font(.body)

                Divider()

                // Disposición inicial
                Group {
                    Text("🙏 Disposición espiritual")
                        .font(.title2).bold()

                    bullet("Haz la señal de la cruz.")
                    bullet("Pide al Espíritu Santo que te acompañe.")
                    bullet("Ofrece el Rosario por una intención concreta (personal, comunitaria o del mundo).")
                }

                // Misterios
                Group {
                    Text("📿 Misterios del Rosario")
                        .font(.title2).bold()

                    VStack(alignment: .leading, spacing: 16) {
                        mysterySection(title: "✨ Misterios Gozosos", days: "Lunes y Sábado", intentions: [
                            "La Encarnación del Hijo de Dios",
                            "La Visitación de María a su prima Isabel",
                            "El nacimiento del Hijo de Dios en Belén",
                            "La presentación de Jesús en el Templo",
                            "El Niño Jesús perdido y hallado en el Templo"
                        ])
                        
                        mysterySection(title: "😢 Misterios Dolorosos", days: "Martes y Viernes", intentions: [
                            "La oración de Jesús en el Huerto",
                            "La flagelación del Señor",
                            "La coronación de espinas",
                            "Jesús carga con la cruz",
                            "La crucifixión y muerte de Jesús"
                        ])
                        
                        mysterySection(title: "🎉 Misterios Gloriosos", days: "Miércoles y Domingo", intentions: [
                            "La Resurrección del Señor",
                            "La Ascensión al cielo",
                            "La venida del Espíritu Santo",
                            "La Asunción de María",
                            "La Coronación de María como Reina del cielo"
                        ])
                        
                        mysterySection(title: "🌟 Misterios Luminosos", days: "Jueves", intentions: [
                            "El Bautismo en el Jordán",
                            "Las bodas de Caná",
                            "El anuncio del Reino de Dios",
                            "La Transfiguración",
                            "La institución de la Eucaristía"
                        ])
                    }
                }

                // Cómo se reza
                Group {
                    Text("🛐 Estructura de una decena")
                        .font(.title2).bold()

                    VStack(alignment: .leading, spacing: 8) {

                        callAndResponse("Ini:", "Padre Nuestro…")
                        callAndResponse("Res:", "Danos hoy nuestro pan de cada día…")

                        callAndResponse("Ini:", "Dios te salve María")
                        callAndResponse("Res:", "Santa María Madre de Dios…")

                        callAndResponse("Ini:", "Gloria al Padre, al Hijo y al Espíritu Santo…")
                        callAndResponse("Res:", "Como era en el principio...")

                        callAndResponse("Ini:", "María es Madre de gracia y Madre de misericordia")
                        callAndResponse("Res:", "En la vida y en la muerte ampáranos dulce madre")

                        callAndResponse("Ini:", "Alabanzas y gracias sean dadas en todo momento al Santísimo y Divinísimo Sacramento del altar")
                        callAndResponse("Res:", "Y bendita sea por siempre la Santa Inmaculada Concepción de la bienaventurada siempre Virgen María Madre de Dios y Madre nuestra.")

                        callAndResponse("Ini:", "Oh, Jesús mío perdona nuestros pecados líbranos del fuego del infierno lleva al cielo a todas las almas especialmente a las más necesitadas de tu infinita misericordia. Amén.")

                        callAndResponse("Ini:", "Sagrado Corazón de Jesús")
                        callAndResponse("Res:", "En vos confío.")

                        callAndResponse("Ini:", "Dulce Corazón de María")
                        callAndResponse("Res:", "Sé la salvación del alma mía.")

                        callAndResponse("Ini:", "San José")
                        callAndResponse("Res:", "Ruega por nosotros.")
                    }
                }

                Group {
                    Text("🕯️ Final del Rosario")
                        .font(.title2).bold()

                    bullet("Oración a San Miguel Arcángel.")
                    bullet("Salve.")
                    Text("Oración final")
                        .bold()
                    bullet("Bajo tu protección nos acogemos Santa Madre de Dios, no desprecies nuestras súplicas en nuestras necesidades; antes bien, líbranos siempre de todos los peligros, Oh, Virgen gloriosa y bendita.\nEn el nombre del Padre, del Hijo y del Espíritu Santo Amén.")
                }
            }
            .padding()
        }
        .navigationTitle("El Santo Rosario")
        .background(Color(.systemGroupedBackground))
    }

    // MARK: - Bullet helper
    @ViewBuilder
    func bullet(_ text: String) -> some View {
        HStack(alignment: .top) {
            Text("•").bold()
            Text(text)
        }
    }
    
    @ViewBuilder
    func callAndResponse(_ label: String, _ text: String) -> some View {
        HStack(alignment: .top) {
            Text(label)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
            Text(text)
        }
    }

    // MARK: - Misterios
    @ViewBuilder
    func mysterySection(title: String, days: String, intentions: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text("Se rezan los \(days).")
                .font(.subheadline)
                .foregroundColor(.secondary)

            ForEach(intentions, id: \.self) { intention in
                bullet(intention)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    NavigationStack {
        RosarioView()
            .environment(\.colorScheme, .dark)
    }
}
