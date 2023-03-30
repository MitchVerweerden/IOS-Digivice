import SwiftUI

struct FavoriteView: View {
    @State var digimon: DigimonFullData?
    let favoriteKey = "favorite"
    var body: some View {
      
        VStack{
            Text(digimon?.name ?? "Leeg")
        }.onAppear(perform: loadData)
       
    }
    func loadData() {
        if let data = UserDefaults.standard.object(forKey: favoriteKey) as? Data,
           let newDigimon = try? JSONDecoder().decode(DigimonFullData.self, from: data) {
            self.digimon = newDigimon
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
