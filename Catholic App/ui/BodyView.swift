import SwiftUI
import CacheManager

struct ShowBodyView: View {
    @StateObject private var viewModel = BibleApiViewModel(cache: CacheManager())

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 6) {
                    
                    Image("rosario_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 250)
                        .clipped()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(Constants.keys.list, id: \.0) { item in
                                Button(action: {
                                    print("Botón \(item.0) presionado")
                                }) {
                                    VStack {
                                        Text(item.1)
                                            .font(.system(size: 30))
                                        Text(item.0)
                                            .font(.caption)
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 80, height: 80)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(16)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    
                    if let versiculo = viewModel.versiculo {
                        Text("\(versiculo.libro.localizedUppercase) \(versiculo.capitulo), \(versiculo.versiculo)")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .bold()
                        
                        Text(versiculo.texto)
                            .padding()
                    } else {
                        Text("Cargando...!")
                            .padding()
                    }
                    
                    VStack(alignment: .center) {
                        HStack(spacing: 16) {
                            NavigationLink(destination: TipsView()) {
                                MenuItem(icon: Constants.Icons.tips, title: Constants.labels.Tip)
                            }
                            .foregroundColor(.black)
                            NavigationLink(destination: RosarioView()) {
                                MenuItem(icon: Constants.Icons.rosario, title: Constants.labels.Rosary)
                            }
                            .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack(spacing: 16) {
                            NavigationLink(destination: LetaniasView()) {
                                MenuItem(icon: Constants.Icons.letanias, title: Constants.labels.Letanies)
                            }
                            .foregroundColor(.black)
                            NavigationLink(destination: HowToPrayView()) {
                                MenuItem(icon: Constants.Icons.howPray, title: Constants.labels.HowPray)
                            }
                            .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding()
                    .cornerRadius(16)
                    
                    Spacer()
                }
                .onAppear {
                    Task {
                        await viewModel.fetchRandomVersicle()
                    }
                }
            }
        }
    }
}

struct MenuItem: View {
    let icon: String
    let title: String

    var body: some View {
        VStack {
            if icon.unicodeScalars.first?.properties.isEmojiPresentation == true {
                Text(icon)
                    .font(.system(size: 50))
            } else {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            Text(title)
                .font(.caption)
        }
        .frame(width: 160, height: 80, alignment: .center)
        .background(Color.blue.opacity(0.2))
        .cornerRadius(16)
    }
}

#Preview {
    ShowBodyView()
}
