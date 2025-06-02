import Foundation

enum LiturgicalEventType: String, Codable {
    case saint, solemnity, feast
}

struct LiturgicalEvent: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let title: String
    let description: String
    let type: LiturgicalEventType
    let link: String?
}

// Modelo para decodificar la respuesta del backend
struct SantoResponse: Codable {
    let name: String
    let description: String
    let date: String  // ej: "23 de febrero"
    let day: Int
    let link: String

    // Si quieres, puedes agregar un computed property para convertir el string "23 de febrero" en Date:
    var dateAsDate: Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "d 'de' MMMM" // ejemplo: 23 de febrero
        // Necesitamos agregar el año actual para crear un Date válido
        let currentYear = Calendar.current.component(.year, from: Date())
        let dateString = "\(day) de \(monthName) \(currentYear)"

        formatter.dateFormat = "d 'de' MMMM yyyy"
        return formatter.date(from: dateString)
    }

    private var monthName: String {
        // Extraemos el mes del string date "23 de febrero"
        let parts = date.components(separatedBy: " ")
        guard parts.count >= 3 else { return "" }
        return parts[2] // "febrero"
    }
}
