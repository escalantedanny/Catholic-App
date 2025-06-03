import SwiftUI


struct ResourcesView: View {
    var body: some View {
        List {
            Section(header: Text("Documentos eclesiásticos")) {
                NavigationLink("📜 Biblioteca de documentos", destination: ChurchDocumentsView())
            }
            
            Section(header: Text("Formación en línea")) {
                NavigationLink("🎓 Cursos y talleres", destination: OnlineCoursesView())
            }
            
            Section(header: Text("Contenido para jóvenes")) {
                NavigationLink("👧🧒 Sección para niños y jóvenes", destination: YouthResourcesView())
            }
        }
        .navigationTitle("📚 Recursos y Formación")
    }
}


#Preview {
    ResourcesView()
}
