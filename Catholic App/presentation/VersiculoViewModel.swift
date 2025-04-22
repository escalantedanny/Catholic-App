import SwiftUI
import Combine

class VersiculoViewModel: ObservableObject {
    @Published var versiculo: Versiculo?  // La propiedad que actualizará la vista

    // Función para obtener un versículo aleatorio desde la API.
    func fetchRandomVersicle() {
        // URL de la API
        guard let url = URL(string: "https://bible-api-a2sa.onrender.com/libros/versiculos/aleatorios") else {
            print("URL inválida")
            return
        }
        
        // Hacer la solicitud
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error al obtener datos: \(error.localizedDescription)")
                return
            }
            
            // Decodificar la respuesta JSON
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    // Decodificar el JSON en la estructura Versiculo
                    let versiculo = try decoder.decode(Versiculo.self, from: data)
                    DispatchQueue.main.async {
                        // Actualizar el estado del viewModel en el hilo principal
                        self.versiculo = versiculo
                    }
                } catch {
                    print("Error al decodificar los datos: \(error)")
                }
            }
        }.resume()  // Iniciar la tarea en segundo plano
    }
}
