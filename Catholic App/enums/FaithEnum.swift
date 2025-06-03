import Foundation
import MapKit

struct FaithEvent: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let startDate: Date
    let endDate: Date?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    let category: FaithEventCategory

    var formattedDateRange: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "d 'de' MMMM"

        let year = Calendar.current.component(.year, from: startDate)

        if let endDate = endDate {
            let startFormatted = formatter.string(from: startDate)
            let endFormatted = formatter.string(from: endDate)
            return "\(startFormatted) al \(endFormatted) de \(year)"
        } else {
            let fullFormatted = formatter.string(from: startDate)
            return "\(fullFormatted) de \(year)"
        }
    }
}

extension FaithEvent {
    static let sampleEvents: [FaithEvent] = [
        FaithEvent(
            title: "Retiro EMAUS",
            description: "Retiro de meditación espiritual para reflexionar sobre la fe con base al pasaje de EMAUS.",
            startDate: DateComponents(calendar: .current, year: 2025, month: 6, day: 27).date!,
            endDate: DateComponents(calendar: .current, year: 2025, month: 6, day: 29).date!,
            locationName: "Parroquia Italiana Latinoamericana Nsta. Sra. de Pompeya",
            coordinate: CLLocationCoordinate2D(latitude: -33.44368351468777, longitude: -70.63053702806856),
            category: .retiros
        ),
        FaithEvent(
            title: "Taller de Oración y Vida",
            description: "Los TOV son un movimiento laical dentro de la Iglesia Católica, compuesto por fieles que, después de recibir la formación, se convierten en guias para impartir talleres a otras personas. con la Tallerista Iris.",
            startDate: DateComponents(calendar: .current, year: 2025, month: 3, day: 1).date!,
            endDate: DateComponents(calendar: .current, year: 2025, month: 7, day: 30).date!,
            locationName: "Parroquia Italiana Latinoamericana Nsta. Sra. de Pompeya ",
            coordinate: CLLocationCoordinate2D(latitude: -33.44368351468777, longitude: -70.63053702806856),
            category: .talleres
        )
    ]
}

enum FaithEventCategory: String, CaseIterable {
    case retiros = "Sesión de Retiros"
    case talleres = "Sesión de Talleres"
    case misas = "Misas"
    case grupos = "Grupos de Oración"
}
