import SwiftUI
struct BottomBarView: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            Button(action: {
                selectedTab = 0
            }) {
                VStack {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    Text("Inicio")
                }
                .foregroundColor(selectedTab == 0 ? .blue : .gray)
            }
            Spacer()
            Button(action: {
                selectedTab = 1
            }) {
                VStack {
                    Image(systemName: selectedTab == 1 ? "magnifyingglass.circle.fill" : "magnifyingglass.circle")
                    Text("Buscar")
                }
                .foregroundColor(selectedTab == 1 ? .blue : .gray)
            }
            Spacer()
            Button(action: {
                selectedTab = 2
            }) {
                VStack {
                    Image(systemName: selectedTab == 2 ? "book.fill" : "book")
                    Text("Biblia")
                }
                .foregroundColor(selectedTab == 2 ? .blue : .gray)
            }
            Spacer()
            Button(action: {
                selectedTab = 3
            }) {
                VStack {
                    Image(systemName: selectedTab == 3 ? "book.closed.fill" : "book.closed")
                    Text("Evangelio")
                }
                .foregroundColor(selectedTab == 3 ? .blue : .gray)
            }
            Spacer()
            Button(action: {
                selectedTab = 4
            }) {
                VStack {
                    Image(systemName: selectedTab == 4 ? "person.circle.fill" : "person.circle")
                    Text("Yo")
                }
                .foregroundColor(selectedTab == 4 ? .blue : .gray)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 32)
        .background(Color(.systemBackground))
    }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    var content: (Binding<Value>) -> Content

    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}

#Preview {
    StatefulPreviewWrapper(0) { binding in
        BottomBarView(selectedTab: binding)
    }
    //.environment(\.colorScheme, .dark)
}
