import SwiftUI

struct SideMenuView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
           VStack(alignment: .leading, spacing: 20) {
               Text(Constants.Titles.menu)
                   .font(.title)
                   .bold()
                   .padding(.top, 60)

               Divider()

               Button(action: {
                   withAnimation {
                       showMenu = false
                   }
               }) {
                   Label(Constants.Titles.home, systemImage: Constants.Icons.home)
               }

               Button(action: {
                   withAnimation {
                       showMenu = false
                   }
               }) {
                   Label(Constants.Titles.settings, systemImage: Constants.Icons.gear)
               }

               Button(action: {
                   withAnimation {
                       showMenu = false
                   }
               }) {
                   Label(Constants.Titles.closeCession, systemImage: Constants.Icons.arrowBackward)
               }

               Spacer()
           }
           .padding(.horizontal, 20)
           .padding(.top, 40)
           .foregroundColor(.black)
       }
}

#Preview {
    SideMenuView(showMenu: .constant(true))
}

