import Foundation
import MapKit

struct FaithEvent: Codable, Identifiable {
    var id: UUID = UUID()
    let title: String
    let description: String
    let startDate: Date
    let endDate: Date
    let locationName: String
    let coordinate: Coordinate
    let category: FaithEventCategory

    var formattedDateRange: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "d 'de' MMMM"
        return "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))"
    }

    var coordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }

    private enum CodingKeys: String, CodingKey {
        case title, description, startDate, endDate, locationName, coordinate, category
    }
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}

enum FaithEventCategory: String, Codable, CaseIterable, Hashable {
    case retiros
    case talleres
    case misas
    case grupos

    var label: String {
        switch self {
        case .retiros: return "Retiros"
        case .talleres: return "Talleres"
        case .misas: return "Misas"
        case .grupos: return "Grupos de Oración"
        }
    }
}
