import Foundation

struct EvangelioResponse: Codable {
    let fecha: String
    let liturgiaDeLaPalabra: [String]
    let salmo: [String]
    let evangelio: [String]
}
