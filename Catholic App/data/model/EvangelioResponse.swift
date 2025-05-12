import Foundation

struct EvangelioResponse: Codable {
    let liturgiaDeLaPalabra: [String]
    let salmo: [String]
    let evangelio: [String]
}
