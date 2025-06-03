import SwiftUI
import Resolver

struct LiturgicalAgendaView: View {
    @State private var selectedDate = Date()
    @State private var events: [LiturgicalEvent] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var liturgicalInfo: LiturgicalCycleInfo?

    @StateObject private var viewModel: ToolsViewModel = Resolver.resolve()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    datePickerSection

                    if let info = liturgicalInfo {
                        LiturgicalInfoView(info: info)
                    }

                    CountdownSection(viewModel: viewModel, date: selectedDate)

                    contentSection
                }
                .padding(.top)
            }
            .navigationTitle("Agenda Litúrgica")
            .onAppear {
                loadEvents(for: selectedDate)
            }
        }
    }

    private var datePickerSection: some View {
        DatePicker("", selection: $selectedDate, displayedComponents: .date)
            .datePickerStyle(.graphical)
            .padding(.horizontal)
            .onChange(of: selectedDate) { _, newDate in
                loadEvents(for: newDate)
            }
    }

    private var contentSection: some View {
        Group {
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
                VStack(alignment: .leading, spacing: 16) {
                    Text("Santos del día")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)

                    ForEach(events) { event in
                        LiturgicalEventCard(event: event)
                    }
                }
                .padding(.bottom)
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
            let cycleInfo = viewModel.getLiturgicalCycle(for: date)
            DispatchQueue.main.async {
                self.events = fetchedEvents
                self.liturgicalInfo = cycleInfo
                self.isLoading = false
            }
        }
    }
}

struct LiturgicalInfoView: View {
    let info: LiturgicalCycleInfo

    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(info.liturgicalColor.colorValue)
                .frame(width: 24, height: 24)
                .overlay(Circle().stroke(Color.primary, lineWidth: 1))

            VStack(alignment: .leading) {
                Text("Tiempo: \(info.season)")
                    .font(.subheadline)
                Text("Año litúrgico: \(info.yearCycle)")
                    .font(.subheadline)
            }

            Spacer()
        }
        .padding(.horizontal)
    }
}

struct CountdownSection: View {
    let viewModel: ToolsViewModel
    let date: Date

    var body: some View {
        let countdowns = viewModel.getKeyLiturgicalCountdownEvents(from: date)

        if countdowns.isEmpty {
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 8) {
                Text("Cuenta regresiva")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)

                ForEach(countdowns) { event in
                    HStack {
                        Text(event.title)
                        Spacer()
                        Text("\(viewModel.daysBetween(date, event.targetDate)) días")
                            .foregroundColor(.blue)
                            .bold()
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct LiturgicalEventCard: View {
    let event: LiturgicalEvent

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {

                VStack(alignment: .leading, spacing: 4) {
                    Text(event.title)
                        .font(.headline)

                    Text(event.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            if let link = event.link, let url = URL(string: link) {
                HStack {
                    Button(action: {
                        UIApplication.shared.open(url)
                    }) {
                        Label("Conocer más", systemImage: "link")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
            } else {
                HStack {
                    Spacer()
                    Label("Sin enlace disponible", systemImage: "nosign")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    LiturgicalAgendaView()
}
