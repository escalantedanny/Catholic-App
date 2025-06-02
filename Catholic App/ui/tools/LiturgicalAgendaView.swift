import SwiftUI
import Resolver

struct LiturgicalAgendaView: View {
    @State private var selectedDate = Date()
    @State private var events: [LiturgicalEvent] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    @StateObject private var viewModel: ToolsViewModel = Resolver.resolve()

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Selecciona una fecha", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                    .onChange(of: selectedDate) { oldDate, newDate in
                        loadEvents(for: newDate)
                    }

                if isLoading {
                    ProgressView("Cargando eventos...")
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if events.isEmpty {
                    Text("No hay eventos litúrgicos para esta fecha.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(events) { event in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(event.title)
                                    .font(.headline)

                                Text(event.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                if let link = event.link, let url = URL(string: link) {
                                    Text("Conocer más sobre este santo")
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                        .onTapGesture {
                                            UIApplication.shared.open(url)
                                        }
                                } else {
                                    Text("Conocer más sobre este santo")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Agenda Litúrgica")
            .onAppear {
                loadEvents(for: selectedDate)
            }
        }
    }

    private func loadEvents(for date: Date) {
        isLoading = true
        errorMessage = nil

        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)

        Task {
            let fetchedEvents = await viewModel.fetchSaintsOfDay(month: month, day: day)
            DispatchQueue.main.async {
                self.events = fetchedEvents
                self.isLoading = false
            }
        }
    }
}

#Preview {
    LiturgicalAgendaView()
}
