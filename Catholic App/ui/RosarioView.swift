import SwiftUI

struct RosarioView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Aprenda el paso a paso para rezar el Rosario")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 8)

                Group {
                    Text("📿 Los Misterios")
                        .font(.headline)

                    Text("El Rosario está compuesto por 20 \"misterios\" (momentos significativos) de la vida de Jesús y de María, divididos desde la publicación de la Carta apostólica *Rosarium Virginis Mariae* en cuatro \"rosarios\".")

                    VStack(alignment: .leading, spacing: 8) {
                        Text("✨ Misterios Gozosos (lunes y sábado)")
                            .bold()
                        bullet("La Encarnación del Hijo de Dios")
                        bullet("La Visitación de nuestra Señora a su prima Isabel")
                        bullet("El nacimiento del Hijo de Dios en el portal de Belén")
                        bullet("La presentación de Jesús en el Templo")
                        bullet("El Niño Jesús perdido y hallado en el Templo")

                        Text("😢 Misterios Dolorosos (martes y viernes)")
                            .bold().padding(.top)
                        bullet("La oración en el Huerto")
                        bullet("La flagelación de Jesús atado a la columna")
                        bullet("La coronación de espinas")
                        bullet("Jesús con la cruz a cuestas camino del Calvario")
                        bullet("La crucifixión y muerte de Jesús")

                        Text("🎉 Misterios Gloriosos (miércoles y domingo)")
                            .bold().padding(.top)
                        bullet("La Resurrección del Hijo de Dios")
                        bullet("La Ascensión del Señor al cielo")
                        bullet("La venida del Espíritu Santo")
                        bullet("La Asunción de María al cielo")
                        bullet("La Coronación de María como Reina y Señora de todo lo creado")

                        Text("🌟 Misterios Luminosos (jueves)")
                            .bold().padding(.top)
                        bullet("El Bautismo en el Jordán")
                        bullet("Las bodas de Caná")
                        bullet("El anuncio del Reino de Dios")
                        bullet("La Transfiguración")
                        bullet("La instauración de la Eucaristía")
                    }
                }

                Group {
                    Text("🙏 ¿Cómo se reza?")
                        .font(.headline)
                        .padding(.top)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("1. Inicio: señal de la cruz y acto de contrición.")
                        Text("Por la señal de la Santa Cruz, de nuestros enemigos líbranos Señor Dios Nuestro. En el nombre del Padre, del Hijo y del Espíritu Santo. Amén.")
                        Text("Señor mío Jesucristo, Dios y hombre verdadero, Creador, Padre y Redentor mío... (oración completa).")
                        
                        Text("2. Rezar el Padre Nuestro.")
                        Text("3. Rezar 3 Avemarías y un Gloria al Padre.")
                        Text("4. Anunciar el primer misterio. Rezar el Padrenuestro.")
                        Text("5. Rezar 10 Avemarías y un Gloria al Padre.")
                        Text("6. Rezar un María, Madre de gracia y un Oh, Jesús Mío.")
                        Text("María, Madre de gracia, Madre de misericordia...")
                        Text("Oh Jesús mío, perdónanos...")

                        Text("7. Repetir para el segundo, tercero, cuarto y quinto misterio.")
                        Text("8. Rezar letanías de la Santísima Virgen.")
                        Text("9. Rezar el Cordero de Dios:")
                        Text("Cordero de Dios, que quitas el pecado del mundo...")

                        Text("10. Rezar las intenciones del Santo Padre:")
                        Text("Padre nuestro, que estás en el cielo...")

                        Text("11. Rezar el Salve a la Virgen María.")
                        Text("12. Jaculatoria final: Ave María Purísima. Sin pecado concebida.")
                        Text("13. Señal de la cruz y santiguamiento.")
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
    }

    // Helper function to create bullet points
    @ViewBuilder
    func bullet(_ text: String) -> some View {
        HStack(alignment: .top) {
            Text("•")
            Text(text)
        }
    }
}

#Preview {
    RosarioView()
        .environment(\.colorScheme, .dark)

}
