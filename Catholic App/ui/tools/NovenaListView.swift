import UserNotifications
import SwiftUI
import SwiftUICore

struct Novena: Identifiable {
    let id = UUID()
    let title: String
    let prayers: [String] // 9 oraciones, una por día
}

extension Novena {
    static let samples = [
        Novena(
            title: "Novena al Sagrado Corazón",
            prayers: (1...9).map { "Oración del día \($0): Lorem ipsum dolor sit amet..." }
        ),
        Novena(
            title: "Novena a la Virgen María",
            prayers: (1...9).map { "Oración del día \($0): Ave María, llena eres de gracia..." }
        )
    ]
}

struct NovenaListView: View {
    let novenas: [Novena] = Novena.samples

    var body: some View {
        NavigationStack {
            List(novenas) { novena in
                NavigationLink(destination: NovenaDetailView(novena: novena)) {
                    VStack(alignment: .leading) {
                        Text(novena.title).bold()
                        Text("Duración: 9 días")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Planificador de Novenas")
        }
    }
}

struct NovenaDetailView: View {
    let novena: Novena
    @State private var started = false
    @State private var startDate = Date()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(novena.title)
                .font(.title)
                .bold()

            Text("Duración: 9 días")

            if started {
                Text("Novena iniciada el \(startDate.formatted(date: .long, time: .omitted))")
                ForEach(0..<novena.prayers.count, id: \.self) { day in
                    VStack(alignment: .leading) {
                        Text("Día \(day + 1)").bold()
                        Text(novena.prayers[day])
                            .font(.body)
                            .padding(.bottom)
                    }
                }
            } else {
                Button("Iniciar Novena") {
                    started = true
                    startDate = Date()
                    scheduleNovenaNotifications()
                }
                .buttonStyle(.borderedProminent)
            }

            Spacer()
        }
        .padding()
        //.navigationTitle(novena.title)
    }

    func scheduleNovenaNotifications() {
        for day in 0..<novena.prayers.count {
            let content = UNMutableNotificationContent()
            //content.title = "Novena: \(novena.title)"
            content.body = novena.prayers[day]
            content.sound = .default

            let triggerDate = Calendar.current.date(byAdding: .day, value: day, to: Date())!
            let triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
            var components = triggerComponents
            components.hour = 9

            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "\(novena.id)-day\(day + 1)", content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request)
        }
    }
}

#Preview {
    NovenaListView()
}
