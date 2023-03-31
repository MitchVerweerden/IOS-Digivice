import SwiftUI

struct DigimonDetails: View {
    var details: DigimonFullData?
    var body: some View {
        VStack {
            Text(getDigimonName())
            AsyncImage(url: URL(string: getImageURL())) {image in image.resizable()}
        placeholder: {
            ProgressView()
        }
        .clipShape(Circle())
        .overlay(
            Circle().stroke(
                .green,
                lineWidth: 4))
        .shadow(radius: 7)
        .frame(width: 200, height: 200)
            Text("Attribute: " + getDigimonAttribute())
            Text("Level: " + getDigimonLevel())
        }
    }
    
    func getImageURL() -> String {
        return details?.images[0].href ?? "https://picsum.photos/200/300"
    }
    
    func getDigimonName() -> String {
        return details?.name ?? "Kerel"
    }
    
    func getDigimonAttribute() -> String {
        
        return details?.attributes[0].attribute ?? "Man"
    }
    
    func getDigimonLevel() -> String {
        return details?.levels[0].level ?? "Champion"
    }

}

struct DigimonDetails_Previews: PreviewProvider {
    static var previews: some View {
        DigimonDetails()
    }
}
