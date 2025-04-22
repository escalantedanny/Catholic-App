import SwiftUI

struct TopBarView: View {
    var body: some View {
            HStack {
                Text(Constants.Titles.appName)
                    .font(.title2)
                    .bold()
                Spacer()
                Image(systemName: Constants.Icons.menu)
                    .padding()
            }
            .padding()
            .background(Color.white)
            .foregroundColor(.black)
            .frame(height: 60)
        }
}

#Preview {
    TopBarView()
}
