import Foundation

struct DigimonList: Codable {
    var content: [DigimonData]
}

struct DigimonData: Codable {
    var id: Int
    var name: String
    var image: String
    var href: String
}
struct DigimonFullData: Codable {
    var id: Int
    var name: String
    var images: [DigimonImage]
    var descriptions: [Description]
    var attributes: [Attribute]
    var levels: [Level]
}
struct Level: Codable{
    var id: Int
    var level: String
}
struct DigimonImage: Codable{
    var href: String}
struct Attribute: Codable{
    var id: Int
    var attribute: String
}
struct Description: Codable{
    var origin: String
    var language: String
    var description: String
}

struct FavoriteDigimonData: Codable {
    var id: Int
    var name: String
    var images: [DigimonImage]
    var descriptions: [Description]
    var attributes: [Attribute]
    var levels: [Level]
    var experience: Int
}
