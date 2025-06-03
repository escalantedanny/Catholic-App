import SwiftUI

struct BottomBarView: View {
    @Binding var selectedTab: Int

    private let tabs: [(icon: String, selectedIcon: String, title: String)] = [
        ("house", "house.fill", "Inicio"),
        ("magnifyingglass.circle", "magnifyingglass.circle.fill", "Buscar"),
        ("book", "book.fill", "Biblia"),
        ("book.closed", "book.closed.fill", "Evangelio"),
        ("wrench.and.screwdriver", "wrench.and.screwdriver.fill", "Herramientas")
    ]

    var body: some View {
        HStack {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: {
                    selectedTab = index
                }) {
                    VStack {
                        Image(systemName: selectedTab == index ? tabs[index].selectedIcon : tabs[index].icon)
                        Text(tabs[index].title)
                            .font(.caption)
                    }
                    .foregroundColor(selectedTab == index ? .blue : .gray)
                }

                if index < tabs.count - 1 {
                    Spacer()
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 24)
        .background(Color(.systemBackground).ignoresSafeArea(edges: .bottom))
    }
}

// Vista previa para pruebas
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
