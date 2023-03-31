
import SwiftUI

struct EditFavoriteView: View {
    
    @State var name: String
    @State var digimon: DigimonFullData?
    let favoriteKey = "favorite"
      var body: some View {
          VStack(alignment: .leading) {
              TextField("Enter new Name", text: $name)
              Button(action: {
                  self.saveChanges()
              }) {
                  Text("Save changes")
              }.padding()
          }.onAppear(perform: loadData)
      }
    
    func loadData() {
        if let digimonData = UserDefaults.standard.object(forKey: favoriteKey) as? Data,
           let newDigimon = try? JSONDecoder().decode(DigimonFullData.self, from: digimonData) {
            self.digimon = newDigimon
        }
    }
    func saveChanges(){
        self.digimon?.name = name
        if let encodedDigimon = try? JSONEncoder().encode(self.digimon) {
            UserDefaults.standard.set(encodedDigimon, forKey: favoriteKey)
        }
    }
}

