import SwiftUI

struct LetaniasView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Letanías de la Virgen")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 8)

                LetaniaGroupView(title: "Invocaciones iniciales", text: """
                Señor, **ten piedad**  
                Cristo, **ten piedad**  
                Señor, **ten piedad**  
                Cristo, **óyenos**  
                Cristo, **escúchanos**
                """)

                LetaniaGroupView(title: "A la Santísima Trinidad", text: """
                Dios, Padre celestial, **ten piedad de nosotros**  
                Dios, Hijo, Redentor del mundo,  
                Dios, Espíritu Santo,  
                Santísima Trinidad, un solo Dios,  
                **Ten piedad de nosotros**
                """)

                LetaniaGroupView(title: "Invocaciones a María (Madre)", text: """
                Santa María,  
                Santa Madre de Dios,  
                Santa Virgen de las Vírgenes,  
                Madre de Cristo,  
                Madre de la Iglesia,  
                Madre de la misericordia,  
                Madre de la divina gracia,  
                Madre de la esperanza,  
                Madre purísima,  
                Madre castísima,  
                Madre siempre virgen,  
                Madre inmaculada,  
                Madre amable,  
                Madre admirable,  
                Madre del buen consejo,  
                Madre del Creador,  
                Madre del Salvador,  
                **R: ruega por nosotros**
                """)

                LetaniaGroupView(title: "Invocaciones a María (Virtudes y símbolos)", text: """
                Virgen prudentísima,  
                Virgen digna de veneración,  
                Virgen digna de alabanza,  
                Virgen poderosa,  
                Virgen clemente,  
                Virgen fiel,  
                Espejo de justicia,  
                Trono de la sabiduría,  
                Causa de nuestra alegría,  
                Vaso espiritual,  
                Vaso digno de honor,  
                Vaso de insigne devoción,  
                Rosa mística,  
                Torre de David,  
                Torre de marfil,  
                Casa de oro,  
                Arca de la Alianza,  
                Puerta del cielo,  
                Estrella de la mañana,  
                **R: ruega por nosotros**
                """)

                LetaniaGroupView(title: "Invocaciones finales", text: """
                Salud de los enfermos,  
                Refugio de los pecadores,  
                Consuelo de los migrantes,  
                Consoladora de los afligidos,  
                Auxilio de los cristianos,  
                **R: ruega por nosotros**
                
                Reina de los Ángeles,  
                Reina de los Patriarcas,  
                Reina de los Profetas,  
                Reina de los Apóstoles,  
                Reina de los Mártires,  
                Reina de los Confesores,  
                Reina de las Vírgenes,  
                Reina de todos los Santos,  
                Reina concebida sin pecado original,  
                Reina asunta a los Cielos,  
                Reina del Santísimo Rosario,  
                Reina de la familia,  
                Reina de la paz,  
                **R: ruega por nosotros**
                """)

                LetaniaGroupView(title: "Cordero de Dios", text: """
                Cordero de Dios, que quitas el pecado del mundo, **perdónanos, Señor**  
                Cordero de Dios, que quitas el pecado del mundo, **escúchanos, Señor**  
                Cordero de Dios, que quitas el pecado del mundo, **ten misericordia de nosotros**
                """)

                LetaniaGroupView(title: "Oración final", text: """
                Ruega por nosotros, Santa Madre de Dios.  
                Para que seamos dignos de las promesas de Cristo.

                **ORACIÓN**  
                Te rogamos nos concedas, Señor Dios nuestro, gozar de continua salud de alma y cuerpo, y por la gloriosa intercesión de la bienaventurada siempre Virgen María, vernos libres de las tristezas de la vida presente y disfrutar de las alegrías eternas. Por Cristo nuestro Señor. Amén.
                """)
            }
            .padding()
        }
        .background(Color(.systemBackground))
    }
}

struct LetaniaGroupView: View {
    let title: String
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.accentColor)
            Text(LocalizedStringKey(text)) // Soporta markdown como **negrita**
                .font(.body)
        }
    }
}

#Preview {
    LetaniasView()
        .environment(\.colorScheme, .dark)
}
