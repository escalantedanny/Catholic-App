import SwiftUI

struct BasicTopBarView: View {
    @Binding var showMenu: Bool

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                withAnimation {
                    showMenu = true
                }
            }) {
                Image(systemName: Constants.Icons.menu)
                    .padding()
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
        .foregroundColor(.blue)
    }
}

struct DetailTopBarMenu: View {
    @Binding var showMenu: Bool

    var body: some View {
        HStack {
            Spacer()
            Button {
                withAnimation {
                    showMenu.toggle()
                }
            } label: {
                Image(systemName: Constants.Icons.menu)
                    .font(.system(size: 24))
                    .padding()
                    .bold()
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .frame(height: 60)
    }
}


#Preview {
    DetailTopBarMenu(showMenu: .constant(true))
        .environment(\.colorScheme, .dark)

}
