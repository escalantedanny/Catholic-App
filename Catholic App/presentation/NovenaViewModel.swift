import SwiftUI

class NovenaViewModel: ObservableObject {
    @Published var novenas: [Novena] = Novena.list
    @Published var activeNovena: Novena?
    @Published var startDate: Date?
    @Published var manualDayIndex: Int?

    private let novenaKey = "active_novena"
    private let startDateKey = "novena_start_date"

    var currentDayIndex: Int {
        guard let start = startDate else { return 0 }
        let days = Calendar.current.dateComponents([.day], from: start, to: Date()).day ?? 0
        return min(days, activeNovena?.prayers.count ?? 1 - 1)
    }

    var currentPrayer: DailyPrayer? {
        guard let novena = activeNovena else { return nil }
        let index = manualDayIndex ?? currentDayIndex
        return novena.prayers[index]
    }

    init() {
        loadActiveNovena()
    }

    func startNovena(_ novena: Novena) {
        activeNovena = novena
        startDate = Date()
        manualDayIndex = 0
        saveActiveNovena()
    }

    func goToNextDay() {
        guard let novena = activeNovena else { return }
        let next = (manualDayIndex ?? currentDayIndex) + 1
        if next < novena.prayers.count {
            manualDayIndex = next
        }
    }

    func goToPreviousDay() {
        let prev = (manualDayIndex ?? currentDayIndex) - 1
        if prev >= 0 {
            manualDayIndex = prev
        }
    }

    func isFirstDay() -> Bool {
        (manualDayIndex ?? currentDayIndex) == 0
    }

    func isLastDay() -> Bool {
        guard let novena = activeNovena else { return true }
        return (manualDayIndex ?? currentDayIndex) >= (novena.prayers.count - 1)
    }

    func saveActiveNovena() {
        guard let novena = activeNovena,
              let data = try? JSONEncoder().encode(novena) else { return }
        UserDefaults.standard.set(data, forKey: novenaKey)
        UserDefaults.standard.set(startDate, forKey: startDateKey)
    }

    func loadActiveNovena() {
        guard let data = UserDefaults.standard.data(forKey: novenaKey),
              let novena = try? JSONDecoder().decode(Novena.self, from: data),
              let start = UserDefaults.standard.object(forKey: startDateKey) as? Date else { return }
        activeNovena = novena
        startDate = start
    }

    func resetNovena() {
        activeNovena = nil
        startDate = nil
        manualDayIndex = nil
        UserDefaults.standard.removeObject(forKey: novenaKey)
        UserDefaults.standard.removeObject(forKey: startDateKey)
    }

    func scheduleNovenaNotifications() {
        guard let novena = activeNovena else { return }
        for day in 0..<novena.prayers.count {
            let content = UNMutableNotificationContent()
            content.title = "Novena: \(novena.title) - Día \(day + 1)"
            content.body = novena.prayers[day].prayer
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
}
