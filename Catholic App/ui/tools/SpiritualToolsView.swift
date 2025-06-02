import SwiftUI

struct SpiritualToolsView: View {

    var body: some View {
        //NavigationStack() {
            VStack(spacing: 24) {
                Text("📅 Herramientas de Organización Espiritual")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.top)


                NavigationLink(value: ToolEnumDestination.calendary) {
                    ToolCardView(
                        emoji: "📅",
                        title: "Agenda litúrgica",
                        description: "Calendario con festividades, santos del día y eventos litúrgicos."
                    )
                }

                NavigationLink(value: ToolEnumDestination.remenber) {
                    ToolCardView(
                        emoji: "⏰",
                        title: "Recordatorios de oración y confesión",
                        description: "Notificaciones diarias o mensuales para rezar o confesarte."
                    )
                }

                NavigationLink(value: ToolEnumDestination.prays) {
                    ToolCardView(
                        emoji: "🙏",
                        title: "Planificador de novenas",
                        description: "Selecciona una novena y recibe las oraciones diarias."
                    )
                }

                Spacer()
            }
            .padding()
            // ✅ Maneja los destinos con enum
            .navigationDestination(for: ToolEnumDestination.self) { destination in
                switch destination {
                case .calendary:
                    LiturgicalAgendaView()
                case .remenber:
                    if #available(iOS 18.0, *) {
                        PrayerAndConfessionReminderView()
                    } else {
                        Text("Disponible solo en iOS 18 o superior")
                    }
                case .prays:
                    if #available(iOS 18.0, *) {
                        NovenaListView()
                    } else {
                        Text("Disponible solo en iOS 18 o superior")
                    }
                }
            }
        //}
    }
}

struct ToolCardView: View {
    let emoji: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Text(emoji)
                .font(.system(size: 40))
                .padding(8)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 1)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
}

#Preview {
    SpiritualToolsPreviewWrapper()
}

struct SpiritualToolsPreviewWrapper: View {
    var body: some View {
        NavigationStack {
            SpiritualToolsView()
                .navigationDestination(for: ToolEnumDestination.self) { destination in
                    // ✅ Solo textos simples para el preview
                    switch destination {
                    case .calendary:
                        Text("Vista Agenda litúrgica")
                    case .remenber:
                        Text("Vista Recordatorios")
                    case .prays:
                        Text("Vista Novenas")
                    }
                }
        }
    }
}
