
import SwiftUI

struct DescriptionButtonView: View {
    var details: DigimonFullData?
    let favoriteKey = "favorite"
    let expKey = "exp"
    var body: some View {
        Button("Add Favorite") {
            addToFavorites()
        }
    }
    
    func addToFavorites() {
        if let encodedDigimon = try? JSONEncoder().encode(details) {
            UserDefaults.standard.set(encodedDigimon, forKey: favoriteKey)
        }
        if let encodedExp = try? JSONEncoder().encode(0.0) {
            UserDefaults.standard.set(encodedExp, forKey: expKey)
        }
    }
}

struct DescriptionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionButtonView()
    }
}
