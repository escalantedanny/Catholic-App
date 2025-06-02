import SwiftUI
import UserNotifications

@available(iOS 18.0, *)
struct PrayerAndConfessionReminderView: View {
    @AppStorage("morningPrayerEnabled") private var morningPrayerEnabled = false
    @AppStorage("morningPrayerTime") private var morningPrayerTime = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!

    @AppStorage("nightPrayerEnabled") private var nightPrayerEnabled = false
    @AppStorage("nightPrayerTime") private var nightPrayerTime = Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!

    @AppStorage("confessionReminderEnabled") private var confessionReminderEnabled = false
    @State private var showConfirmation = false


    var body: some View {
        Form {
            Section(header: Text("⛪️ Oración diaria")) {
                Toggle("Oración de la mañana", isOn: $morningPrayerEnabled)
                if morningPrayerEnabled {
                    DatePicker("Hora", selection: $morningPrayerTime, displayedComponents: .hourAndMinute)
                }

                Toggle("Oración de la noche", isOn: $nightPrayerEnabled)
                if nightPrayerEnabled {
                    DatePicker("Hora", selection: $nightPrayerTime, displayedComponents: .hourAndMinute)
                }
            }

            Section(header: Text("🙏 Confesión mensual")) {
                Toggle("Recordarme cada mes", isOn: $confessionReminderEnabled)
            }

            Section {
                Button("Guardar recordatorios") {
                    requestNotificationPermissions()
                    scheduleAllReminders()
                    showConfirmation = true
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .alert("✅ Recordatorios guardados", isPresented: $showConfirmation) {
            Button("OK", role: .cancel) { }
        }
        .navigationTitle("Recordatorios")
    }

    // Solicita permisos de notificación
    private func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            if !granted {
                print("🔕 Permiso de notificación denegado")
            }
        }
    }

    // Programa las notificaciones
    private func scheduleAllReminders() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        if morningPrayerEnabled {
            scheduleNotification(
                identifier: "morningPrayer",
                title: "🙏 Oración de la mañana",
                body: "Es hora de tu oración matutina.",
                date: morningPrayerTime
            )
        }

        if nightPrayerEnabled {
            scheduleNotification(
                identifier: "nightPrayer",
                title: "🌙 Oración de la noche",
                body: "Haz una pausa para hablar con Dios.",
                date: nightPrayerTime
            )
        }

        if confessionReminderEnabled {
            scheduleMonthlyConfessionReminder()
        }
    }

    // Función genérica para notificaciones diarias
    private func scheduleNotification(identifier: String, title: String, body: String, date: Date) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    // Confesión mensual (día 1 a las 10am)
    private func scheduleMonthlyConfessionReminder() {
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.hour = 10
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let content = UNMutableNotificationContent()
        content.title = "🕊 Recordatorio de confesión"
        content.body = "Recuerda confesarte este mes. Dios siempre te espera con amor."
        content.sound = .default

        let request = UNNotificationRequest(identifier: "confessionReminder", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

#Preview {
    NavigationView {
        if #available(iOS 18.0, *) {
            PrayerAndConfessionReminderView()
        } else {
            // Fallback on earlier versions
        }
    }
}
