import SwiftUICore
import SwiftUI

struct OnlineCoursesView: View {
    var body: some View {
        List {
            Section(header: Text("📘 Teología")) {
                NavigationLink {
                    CourseDetailView(
                        title: "Introducción a la Teología",
                        content: "Explora las bases del pensamiento teológico cristiano: Dios, la fe, la revelación y el papel de la razón en la teología.",
                        linkURL: URL(string: "https://es.catholic.net/op/articulos/18778/cat/648/introduccion-a-la-teologia.html"),
                        linkLabel: "Leer más en Catholic.net"
                    )
                } label: {
                    Label("Introducción a la Teología", systemImage: "book.closed")
                }

                NavigationLink {
                    CourseDetailView(
                        title: "Cristología",
                        content: "Estudia la persona y la misión de Jesucristo: verdadero Dios y verdadero hombre, centro de la fe cristiana.",
                        linkURL: URL(string: "https://es.catholic.net/op/articulos/27941/cat/648/cristologia.html"),
                        linkLabel: "Profundiza sobre Cristo"
                    )
                } label: {
                    Label("Cristología", systemImage: "cross.fill")
                }
            }

            Section(header: Text("🕊️ Liturgia")) {
                NavigationLink {
                    CourseDetailView(
                        title: "Liturgia de las Horas",
                        content: "Conoce la oración oficial de la Iglesia que santifica las horas del día, con salmos, lecturas y oraciones.",
                        linkURL: URL(string: "https://www.vatican.va/archive/spirit/ora.htm"),
                        linkLabel: "Ver Liturgia oficial"
                    )
                } label: {
                    Label("Liturgia de las Horas", systemImage: "clock.arrow.circlepath")
                }

                NavigationLink {
                    CourseDetailView(
                        title: "Misa explicada paso a paso",
                        content: "Aprende el significado de cada parte de la Santa Misa, desde el rito inicial hasta la bendición final.",
                        linkURL: URL(string: "https://aciprensa.com/recursos/estructura-de-la-misa-3945"),
                        linkLabel: "Más sobre la Misa en ACI Prensa"
                    )
                } label: {
                    Label("Misa explicada paso a paso", systemImage: "hands.sparkles")
                }
            }

            Section(header: Text("🏛️ Historia de la Iglesia")) {
                NavigationLink {
                    CourseDetailView(
                        title: "Primeros siglos del cristianismo",
                        content: "Descubre cómo vivían los primeros cristianos, la persecución, los mártires y la expansión del Evangelio.",
                        linkURL: URL(string: "https://es.catholic.net/op/articulos/40179/cat/362/los-primeros-cristianos.html"),
                        linkLabel: "Leer más sobre los primeros cristianos"
                    )
                } label: {
                    Label("Primeros siglos del cristianismo", systemImage: "scroll")
                }

                NavigationLink {
                    CourseDetailView(
                        title: "Reformas y Concilios",
                        content: "Analiza los grandes concilios y las reformas que marcaron la historia de la Iglesia desde el siglo IV en adelante.",
                        linkURL: URL(string: "https://es.catholic.net/op/articulos/57426/cat/648/los-concilios-de-la-iglesia.html"),
                        linkLabel: "Estudia los Concilios"
                    )
                } label: {
                    Label("Reformas y Concilios", systemImage: "building.columns")
                }
            }
        }
        .navigationTitle("🎓 Cursos y Talleres")
        .listStyle(.insetGrouped)
    }
}


struct CourseDetailView: View {
    let title: String
    let content: String
    let linkURL: URL?
    let linkLabel: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .font(.title)
                    .bold()

                Text(content)
                    .font(.body)

                if let linkURL, let linkLabel {
                    Link(linkLabel, destination: linkURL)
                        .font(.body)
                        .foregroundColor(.blue)
                        .padding(.top)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    OnlineCoursesView()
}
