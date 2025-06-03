import SwiftUI

struct CommunityConnectionView: View {
    var body: some View {
        List {
            Section(header: Text("Encuentra y participa")
                .font(.headline)
                .foregroundColor(.accentColor)
                .padding(.top, 8)
            ) {
                NavigationLink {
                    NearbyChurchesView()
                } label: {
                    Label("Mapa de iglesias cercanas", systemImage: "mappin.and.ellipse")
                        .font(.body)
                        .foregroundColor(.primary)
                }

                NavigationLink {
                    Text("Foro de oración comunitario")
                        .font(.body)
                } label: {
                    Label("Foro de oración comunitario", systemImage: "hands.sparkles.fill")
                        .font(.body)
                        .foregroundColor(.primary)
                }

                NavigationLink {
                    FaithEventsView()
                } label: {
                    Label("Eventos y grupos de fe", systemImage: "person.3.sequence.fill")
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
            .listRowBackground(Color(UIColor.systemGroupedBackground))
            .padding(.vertical, 8)
        }
        .navigationTitle("🌐 Comunidad")
        .listStyle(.insetGrouped)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

#Preview {
    NavigationStack {
        CommunityConnectionView()
    }
}
