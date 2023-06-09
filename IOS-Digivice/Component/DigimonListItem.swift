import SwiftUI

struct DigimonListItem: View {
    var digimon: DigimonData
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: digimon.image)) {image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .scaledToFit()
            Text(digimon.name)
            .font(.custom("PixelDigivolve", size: 15))
            .foregroundColor(Color.black)
        }
    }
}


