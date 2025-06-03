import CoreLocation
import Combine

struct Church: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D

    static let sampleData: [Church] = [
        Church(name: "Parroquia El Sagrario", coordinate: CLLocationCoordinate2D(latitude: -33.43783940717233, longitude: -70.65125398282291)),
        Church(name: "Catedral Metropolitana de Santiago", coordinate: CLLocationCoordinate2D(latitude: -33.43756857719084, longitude: -70.65136127117657)),	
        Church(name: "Iglesia de Santo Domingo", coordinate: CLLocationCoordinate2D(latitude: -33.435686408155895, longitude: -70.64962282859892)),
        Church(name: "Iglesia San Francisco de Borja", coordinate: CLLocationCoordinate2D(latitude: -33.440000, longitude: -70.650000)),
        Church(name: "Iglesia de San Francisco", coordinate: CLLocationCoordinate2D(latitude: -33.441000, longitude: -70.650000)),
        Church(name: "Iglesia del Corpus Domini", coordinate: CLLocationCoordinate2D(latitude: -33.440000, longitude: -70.650000)),
        Church(name: "Parroquia Latinoamericana (Nuestra Señora de Pompeya)", coordinate: CLLocationCoordinate2D(latitude: -33.44368351468777, longitude: -70.63053702806856))
    ]
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    @Published var errorMessage: String?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
            manager.startUpdatingLocation()
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            errorMessage = nil
            manager.startUpdatingLocation()
        case .denied, .restricted:
            errorMessage = "Permiso de ubicación denegado o restringido"
        case .notDetermined:
            break
        @unknown default:
            errorMessage = "Estado de autorización desconocido"
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first {
            DispatchQueue.main.async {
                self.location = loc.coordinate
            }
            manager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = "Error al obtener la ubicación: \(error.localizedDescription)"
        }
    }
}
