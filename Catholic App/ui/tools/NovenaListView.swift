import SwiftUI
import UserNotifications

struct Novena: Identifiable, Hashable {
    var id: String { title }
    let title: String
    let prayers: [String]
}


struct NovenaListView: View {
    let novenas: [Novena] = Novena.list

    var body: some View {
        List(novenas) { novena in
            NavigationLink(destination: NovenaDetailView(novena: novena)) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(novena.title)
                        .font(.headline)
                    Text("Duración: 9 días")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Planificador de Novenas")
    }
}

struct NovenaDetailView: View {
    let novena: Novena
    @State private var started = false
    @State private var startDate = Date()
    @State private var showAlert = false
    
    var currentDay: Int {
        let daysPassed = Calendar.current.dateComponents([.day], from: startDate, to: Date()).day ?? 0
        return min(daysPassed, novena.prayers.count - 1)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(novena.title)
                    .font(.title)
                    .bold()

                Text("Duración: 9 días")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                if started {
                    Text("Novena iniciada el \(startDate.formatted(date: .long, time: .omitted))")
                        .font(.footnote)
                        .foregroundColor(.blue)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("📅 Día \(currentDay + 1)")
                            .font(.headline)
                        Text(novena.prayers[currentDay])
                            .font(.body)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                    }
                } else {
                    Button(action: {
                        requestNotificationPermission {
                            started = true
                            startDate = Date()
                            scheduleNovenaNotifications()
                        }
                    }) {
                        Label("Iniciar Novena", systemImage: "play.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 20)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Permiso Denegado", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Para recibir recordatorios de la novena, activa las notificaciones en Configuración.")
        }
    }

    func scheduleNovenaNotifications() {
        for day in 0..<novena.prayers.count {
            let content = UNMutableNotificationContent()
            content.title = "Novena: \(novena.title) - Día \(day + 1)"
            content.body = novena.prayers[day]
            content.sound = .default

            if let triggerDate = Calendar.current.date(byAdding: .day, value: day, to: Date()) {
                var components = Calendar.current.dateComponents([.year, .month, .day], from: triggerDate)
                components.hour = 9
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

                let request = UNNotificationRequest(
                    identifier: "\(novena.id)-day\(day + 1)",
                    content: content,
                    trigger: trigger
                )

                UNUserNotificationCenter.current().add(request)
            }
        }
    }

    func requestNotificationPermission(completion: @escaping () -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            if granted {
                DispatchQueue.main.async {
                    completion()
                }
            } else {
                showAlert = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        NovenaListView()
    }
}

#Preview {
    NavigationStack {
        NovenaDetailView(novena: Novena.list[0])
    }
}
