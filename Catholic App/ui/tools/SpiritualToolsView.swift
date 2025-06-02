import SwiftUI

struct SpiritualToolsView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("📅 Herramientas de Organización Espiritual")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.top)

                    NavigationLink(destination: LiturgicalAgendaView()) {
                        ToolCardView(
                            emoji: "📅",
                            title: "Agenda litúrgica",
                            description: "Calendario con festividades, santos del día y eventos litúrgicos."
                        )
                    }
                    .buttonStyle(PlainButtonStyle())


                    if #available(iOS 18.0, *) {
                        NavigationLink(destination: PrayerAndConfessionReminderView()) {
                            ToolCardView(
                                emoji: "⏰",
                                title: "Recordatorios de oración y confesión",
                                description: "Notificaciones diarias o mensuales para rezar o confesarte."
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    } else {
                        // Fallback on earlier versions
                    }


                    ToolCardView(
                        emoji: "🙏",
                        title: "Planificador de novenas",
                        description: "Selecciona una novena y recibe las oraciones diarias."
                    )
                

                Spacer()
            }
            .padding()
        }
    }
}

struct ToolCardView: View {
    let emoji: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text(emoji)
                .font(.largeTitle)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}

#Preview {
    SpiritualToolsView()
}
