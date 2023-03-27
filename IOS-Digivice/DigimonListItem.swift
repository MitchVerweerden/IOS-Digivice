import SwiftUI

struct DigimonListItem: View {
    var digimonData: DigimonData
    var body: some View {
        Text(digimonData.name)
    }
}

struct DigimonListItem_Previews: PreviewProvider {
    static var previews: some View {
        DigimonListItem()
    }
}
