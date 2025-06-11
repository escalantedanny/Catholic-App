import SwiftUI
import SwiftUI
import AVFoundation

struct YouthResourcesView: View {
    var body: some View {
        List {
            Section(header: Text("📖 Historias bíblicas ilustradas").font(.headline)) {
                NavigationLink {
                    YouthDetailView(
                        title: "La creación del mundo",
                        content: "En el principio, Dios creó el cielo y la tierra. Separó la luz de la oscuridad, creó los mares, animales y al ser humano. Al séptimo día, descansó."
                    )
                } label: {
                    Label("La creación del mundo", systemImage: "globe")
                }

                NavigationLink {
                    YouthDetailView(
                        title: "El arca de Noé",
                        content: "Dios pidió a Noé que construyera un arca para salvar a su familia y a los animales del diluvio. Llovió 40 días y 40 noches. Luego, apareció el arcoíris como signo de alianza."
                    )
                } label: {
                    Label("El arca de Noé", systemImage: "cloud.rain")
                }

                NavigationLink {
                    YouthDetailView(
                        title: "David y Goliat",
                        content: "David, un joven pastor, venció al gigante Goliat con solo una honda y una piedra, confiando en Dios. Nos enseña que la fe es más fuerte que cualquier miedo."
                    )
                } label: {
                    Label("David y Goliat", systemImage: "bolt.horizontal")
                }
            }

            Section(header: Text("📚 Catequesis interactiva").font(.headline)) {
                NavigationLink {
                    YouthDetailView(
                        title: "¿Quién es Jesús?",
                        content: "Jesús es el Hijo de Dios que vino al mundo para salvarnos. Nos enseñó a amar, perdonar y confiar en el Padre. Murió en la cruz y resucitó para darnos vida eterna."
                    )
                } label: {
                    Label("¿Quién es Jesús?", systemImage: "cross.fill")
                }

                NavigationLink {
                    YouthDetailView(
                        title: "Los sacramentos explicados",
                        content: "Los sacramentos son señales del amor de Dios: el Bautismo, la Eucaristía, la Confirmación, la Confesión, el Matrimonio, el Orden sacerdotal y la Unción de los enfermos."
                    )
                } label: {
                    Label("Los sacramentos explicados", systemImage: "heart.text.square")
                }
            }
        }
        .navigationTitle("👧🧒 Para niños y jóvenes")
        .listStyle(.insetGrouped)
    }
}

struct YouthDetailView: View {
    let title: String
    let content: String

    private let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .font(.title)
                    .bold()

                Text(content)
                    .font(.body)

                Button(action: {
                    let utterance = AVSpeechUtterance(string: content)
                    utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
                    synthesizer.speak(utterance)
                }) {
                    Label("Escuchar", systemImage: "speaker.wave.2.fill")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    YouthDetailView(
        title: "La creación del mundo",
        content: "En el principio, Dios creó el cielo y la tierra. Todo estaba vacío y oscuro, pero Dios dijo: 'Que haya luz', y hubo luz."
    )
}
