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
            .frame(width: 50, height: 50)
            
            Text(digimon.name)
        }
    }
}


