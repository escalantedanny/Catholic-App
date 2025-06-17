import SwiftUI
import MapKit


struct NearbyChurchesView: View {
    @State private var position: MapCameraPosition

    init() {
        _position = State(initialValue: .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: -33.44, longitude: -70.65),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        ))
    }

    var body: some View {
        Map(position: $position) {
            ForEach(Church.sampleData) { church in
                Annotation(church.name, coordinate: church.coordinate) {
                    VStack {
                        Image(systemName: "building.columns")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text(church.name)
                            .font(.caption2)
                            .fixedSize()
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationTitle("🗺️ Iglesias en Santiago")
    }
}


struct NearbyChurchesView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyChurchesView_PreviewWrapper()
    }
}

struct NearbyChurchesView_PreviewWrapper: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        NearbyChurchesView()
            .environmentObject(locationManager)
            .onAppear {
                locationManager.location = CLLocationCoordinate2D(latitude: -33.45, longitude: -70.66)
            }
    }
}
