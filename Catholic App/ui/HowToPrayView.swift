import SwiftUI

struct HowToPrayView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Consejos que te ayudarán a orar")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 8)

                Group {
                    Text("**1. Encuentra un lugar tranquilo**\nBusca un espacio donde puedas estar en silencio sin distracciones. La oración necesita recogimiento.")
                    Text("**2. Haz una pausa**\nRespira profundo, relájate y reconoce que estás en la presencia de Dios.")
                    Text("**3. Comienza con una invocación**\nPuedes empezar diciendo: *\"Señor, abre mis labios\"* o *\"Ven, Espíritu Santo\"*.")
                    Text("**4. Agradece**\nReconoce lo bueno que hay en tu vida y da gracias a Dios.")
                    Text("**5. Háblale como a un amigo**\nCuéntale tus alegrías, miedos, dudas, deseos. No necesitas fórmulas complicadas.")
                    Text("**6. Escucha en silencio**\nDespués de hablar, guarda silencio y deja que Dios toque tu corazón.")
                    Text("**7. Lee la Palabra de Dios**\nUn versículo del Evangelio puede ayudarte a meditar y sentirte guiado.")
                    Text("**8. Termina con una oración sencilla**\nPor ejemplo: *\"Gracias, Señor, por este momento contigo\"*.")
                }
                .font(.body)
            }
            .padding()
        }
    }
}

#Preview {
    HowToPrayView()
}
