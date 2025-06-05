import SwiftUI
import MapKit
import Resolver

struct FaithEventsView: View {
    @StateObject private var viewModel: BibleApiViewModel = Resolver.resolve()

    var groupedEvents: [FaithEventCategory: [FaithEvent]] {
        Dictionary(grouping: viewModel.faithEvents, by: { $0.category })
    }

    var body: some View {
        Group {
            List {
                ForEach(FaithEventCategory.allCases, id: \.self) { category in
                    if let events = groupedEvents[category] {
                        Section(header: Text(category.label)) {
                            ForEach(events) { event in
                                NavigationLink {
                                    FaithEventDetailView(event: event)
                                } label: {
                                    VStack(alignment: .leading) {
                                        Text(event.title).font(.headline)
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
            .task {
                await viewModel.loadEvents()
            }
        }
    }
}

struct FaithEventDetailView: View {
    let event: FaithEvent

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(event.title)
                    .font(.title).bold()

                Text(event.description)
                    .font(.body)

                Label(event.formattedDateRange, systemImage: "calendar")
                    .foregroundColor(.secondary)

                Label(event.locationName, systemImage: "mappin.and.ellipse")

                Map(coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: event.coordinate2D,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                ), annotationItems: [event]) { _ in
                    MapMarker(coordinate: event.coordinate2D)
                }
                .frame(height: 200)
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Detalle")
    }
}
