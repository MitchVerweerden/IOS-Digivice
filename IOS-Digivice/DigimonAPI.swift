import Foundation

struct DigimonList: Codable {
    var content: [DigimonData]
}

struct DigimonData: Codable {
    var id: Int
    var name: String
}
