import SwiftUI
import SwiftUI

struct OnlineCoursesView: View {
    var body: some View {
        List {
            Section(header: Text("📘 Teología")) {
                NavigationLink {
                    CourseDetailView(
                        title: "Introducción a la Teología",
                        content: "Explora las bases del pensamiento teológico cristiano: Dios, la fe, la revelación y el papel de la razón en la teología.",
                        linkURL: URL(string: "https://www.vatican.va/roman_curia/congregations/cfaith/cti_documents/rc_cti_doc_20111129_teologia-oggi_sp.html"),
                        linkLabel: "Leer más en vatican.va"
                    )
                } label: {
                    Label("Introducción a la Teología", systemImage: "book.closed")
                }

                NavigationLink {
                    CourseDetailView(
                        title: "Cristología",
                        content: "Estudia la persona y la misión de Jesucristo: verdadero Dios y verdadero hombre, centro de la fe cristiana.",
                        linkURL: URL(string: "https://www.vatican.va/roman_curia/congregations/cfaith/cti_documents/rc_cti_1982_teologia-cristologia-antropologia_sp.html"),
                        linkLabel: "Profundiza sobre Cristo en vatican.va"
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
                        linkURL: URL(string: "https://liturgiadelashoras.github.io"),
                        linkLabel: "Ver Liturgia oficial"
                    )
                } label: {
                    Label("Liturgia de las Horas", systemImage: "clock.arrow.circlepath")
                }

                NavigationLink {
                    CourseDetailView(
                        title: "Misa explicada paso a paso",
                        content: "Aprende el significado de cada parte de la Santa Misa, desde el rito inicial hasta la bendición final.",
                        linkURL: URL(string: "https://www.vatican.va/roman_curia/congregations/ccdds/documents/rc_con_ccdds_doc_20030317_ordinamento-messale_sp.html"),
                        linkLabel: "Más sobre la Misa en vatican.va"
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
                        linkURL: URL(string: "https://es.wikipedia.org/wiki/Cristianismo_en_el_siglo_I#Orígenes_del_cristianismo"),
                        linkLabel: "Leer más sobre los primeros cristianos en wikipedia.org"
                    )
                } label: {
                    Label("Primeros siglos del cristianismo", systemImage: "scroll")
                }

                NavigationLink {
                    CourseDetailView(
                        title: "Reformas y Concilios",
                        content: "Analiza los grandes concilios y las reformas que marcaron la historia de la Iglesia desde el siglo IV en adelante.",
                        linkURL: URL(string: "https://ec.aciprensa.com/wiki/Los_21_Concilios_Ecuménicos"),
                        linkLabel: "Estudia los Concilios en aciprensa.com"
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
