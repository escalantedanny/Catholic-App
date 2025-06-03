import SwiftUI
import MapKit

struct FaithEventsView: View {
    let events = FaithEvent.sampleEvents

    var groupedEvents: [FaithEventCategory: [FaithEvent]] {
        Dictionary(grouping: events, by: { $0.category })
    }

    var body: some View {
        List {
            ForEach(FaithEventCategory.allCases, id: \.self) { category in
                if let categoryEvents = groupedEvents[category] {
                    Section(header: Text(category.rawValue)) {
                        ForEach(categoryEvents) { event in
                            NavigationLink {
                                FaithEventDetailView(event: event)
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(event.title)
                                        .font(.headline)
                                    Text(event.formattedDateRange)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text(event.locationName)
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("🕊️ Eventos y Grupos")
    }
}

struct FaithEventDetailView: View {
    let event: FaithEvent

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(event.title)
                    .font(.title)
                    .bold()

                Text(event.description)
                    .font(.body)

                HStack {
                    Image(systemName: "calendar")
                    Text(event.formattedDateRange)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text(event.locationName)
                }

                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: event.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )), annotationItems: [event]) { item in
                    MapMarker(coordinate: item.coordinate, tint: .blue)
                }
                .frame(height: 200)
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Detalle del Taller")
    }
}

#Preview {
    NavigationStack {
        FaithEventsView()
    }
}
