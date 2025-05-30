import SwiftUI

struct LiturgicalAgendaView: View {
    @State private var selectedDate = Date()
    @State private var events: [LiturgicalEvent] = [] // Aquí cargarás los eventos

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Selecciona una fecha", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()

                List {
                    ForEach(eventsForSelectedDate) { event in
                        VStack(alignment: .leading) {
                            Text(event.title)
                                .font(.headline)
                            Text(event.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(event.type.rawValue.capitalized)
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Agenda Litúrgica")
            .onAppear(perform: loadDummyEvents)
        }
    }

    private var eventsForSelectedDate: [LiturgicalEvent] {
        events.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }

    private func loadDummyEvents() {
        // Por ahora solo ejemplos, luego los cargarás desde tu base de datos o API
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"

        events = [
            LiturgicalEvent(date: formatter.date(from: "2025/05/30")!, title: "San Fernando", description: "Festividad de San Fernando, rey y confesor", type: .saint),
            LiturgicalEvent(date: formatter.date(from: "2025/05/30")!, title: "Santa Misa", description: "Misa del día común", type: .solemnity),
            LiturgicalEvent(date: formatter.date(from: "2025/05/31")!, title: "Visitación de la Virgen María", description: "Fiesta litúrgica", type: .feast)
        ]
    }
}

#Preview {
    LiturgicalAgendaView()
}
