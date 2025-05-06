import SwiftUI

struct BasicTopBarView: View {
    @Binding var showMenu: Bool

    var body: some View {
        HStack {
            Text(Constants.Titles.appName)
                .font(.title2)
                .bold()
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
        .padding(.top, 10) // si quieres espacio desde el top
        .foregroundColor(.white) // blanco si la imagen es oscura
        // Sin .background ni .frame fijo
    }
}

struct DetailTopBarMenu: View {
    @Binding var showMenu: Bool

    var body: some View {
        HStack {
            Text(Constants.Titles.appName)
                .font(.title2)
                .bold()
            Spacer()
            Button {
                withAnimation {
                    showMenu.toggle()
                }
            } label: {
                Image(systemName: Constants.Icons.menu)
                    .padding()
            }
        }
        .padding()
        .background(Color.white)
        .foregroundColor(.black)
        .frame(height: 60)
    }
}


#Preview {
    BasicTopBarView(showMenu: .constant(true))
}
