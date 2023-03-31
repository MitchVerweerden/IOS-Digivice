//
//import SwiftUI
//
//struct DigilutionsView: View {
//    var digilutions: [Evolution]
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(digilutions ?? [], id: \Evolution.id) {digimon in
//                    NavigationLink(destination: DetailView(digimonId: digimon.id ?? 500)) {
//                        DigimonListItem(digimon: digimon)
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct DigilutionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DigilutionsView()
//    }
//}
