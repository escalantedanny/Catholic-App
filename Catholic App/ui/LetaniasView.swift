import SwiftUI

struct LetaniasView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Letanías de la Virgen")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 8)

                Group {
                    Text("Señor, **ten piedad**\nCristo, **ten piedad**\nSeñor, **ten piedad.**\nCristo, **óyenos.**\nCristo, **escúchanos.**")
                    Text("Dios, Padre celestial, **ten piedad de nosotros.\nDios, Hijo, Redentor del mundo,\nDios, Espíritu Santo,\nSantísima Trinidad, un solo Dios,**")
                }

                Group {
                    Text("Santa María,\nSanta Madre de Dios,\nSanta Virgen de las Vírgenes,\nMadre de Cristo,\nMadre de la Iglesia,\nMadre de la misericordia,\nMadre de la divina gracia,\nMadre de la esperanza,\nMadre purísima,\nMadre castísima,\nMadre siempre virgen,\nMadre inmaculada,\nMadre amable,\nMadre admirable,\nMadre del buen consejo,\nMadre del Creador,\nMadre del Salvador,\n**R: ruega por nosotros.**")
                }

                Group {
                    Text("Virgen prudentísima,\nVirgen digna de veneración,\nVirgen digna de alabanza,\nVirgen poderosa,\nVirgen clemente,\nVirgen fiel,")
                    Text("Espejo de justicia,\nTrono de la sabiduría,\nCausa de nuestra alegría,\nVaso espiritual,\nVaso digno de honor,\nVaso de insigne devoción,\nRosa mística,\nTorre de David,\nTorre de marfil,\nCasa de oro,\nArca de la Alianza,\nPuerta del cielo,\nEstrella de la mañana,\n**R: ruega por nosotros.**")
                }

                Group {
                    Text("Salud de los enfermos,\nRefugio de los pecadores,\nConsuelo de los migrantes,\nConsoladora de los afligidos,\nAuxilio de los cristianos,\n**R: ruega por nosotros.**")
                    Text("Reina de los Ángeles,\nReina de los Patriarcas,\nReina de los Profetas,\nReina de los Apóstoles,\nReina de los Mártires,\nReina de los Confesores,\nReina de las Vírgenes,\nReina de todos los Santos,\nReina concebida sin pecado original,\nReina asunta a los Cielos,\nReina del Santísimo Rosario,\nReina de la familia,\nReina de la paz.\n**R: ruega por nosotros.**")
                }

                Group {
                    Text("Cordero de Dios, que quitas el pecado del mundo, **perdónanos, Señor.**\nCordero de Dios, que quitas el pecado del mundo, **escúchanos, Señor.**\nCordero de Dios, que quitas el pecado del mundo, **ten misericordia de nosotros.**")
                }

                Group {
                    Text("Ruega por nosotros, Santa Madre de Dios.\nPara que seamos dignos de las promesas de Cristo.")
                    Text("**ORACIÓN**.\nTe rogamos nos concedas, Señor Dios nuestro, gozar de continua salud de alma y cuerpo, y por la gloriosa intercesión de la bienaventurada siempre Virgen María, vernos libres de las tristezas de la vida presente y disfrutar de las alegrías eternas. Por Cristo nuestro Señor. Amén.")
                        .italic()
                }
            }
            .padding()
        }
    }
}

#Preview {
    LetaniasView()
}
