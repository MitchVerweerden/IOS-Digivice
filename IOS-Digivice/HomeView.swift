import SwiftUI

struct HomeView: View {
    @State var digimonList: [DigimonData]?
    let favoriteKey = "favorite"
    let expKey = "exp"
    var body: some View {
        NavigationView {
            List {
                ForEach(digimonList ?? [], id: \DigimonData.id) {digimon in
                    NavigationLink(destination: DetailView(digimonId: digimon.id)) {
                        DigimonListItem(digimon: digimon)
                    }
                    Button("Favorite"){
                        setFavoriteDigimon(digimonId: digimon.id)
                    }
                }
                NavigationLink(destination: FavoriteView()){
                    Text("Favorite")
                }
            }
        }.onAppear(perform: loadData)
    }
    
    func loadData() {
        var digimonList: DigimonList?
        guard let url = URL(string: "https://www.digi-api.com/api/v1/digimon?page=0")
        else {
            print("Error: failed to construct a URL from string")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data,
            response, error in
            if let error = error {
                print("Error: Fetch failed: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Error: failed to get data from URLSession")
                return
            }
            do {
                digimonList = try
                JSONDecoder().decode(DigimonList.self, from: data)
            } catch let error as NSError {
                print("Error: decoding. In domain= \(error.domain), description= \(error.localizedDescription)")
            }
            if digimonList == nil {
                print("Error: failed to read or decode data.")
            }
            DispatchQueue.main.async {
                self.digimonList = digimonList?.content
            }
        }
        task.resume()
    }
    func setFavoriteDigimon(digimonId: Int){
        var newDigimon: DigimonFullData?
        guard let url = URL(string: "https://digimon-api.com/api/v1/digimon/\(digimonId)")
        else {
            print("Error: failed to construct a URL from string")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data,
            response, error in
            if let error = error {
                print("Error: Fetch failed: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Error: failed to get data from URLSession")
                return
            }
            do {
                newDigimon = try
                JSONDecoder().decode(DigimonFullData.self, from: data)
            } catch let error as NSError {
                print("Error: decoding. In domain= \(error.domain), description= \(error.localizedDescription)")
            }
            if newDigimon == nil {
                print("Error: failed to read or decode data.")
            }
            DispatchQueue.main.async {
                //sla op in defaults
                if let encodedDigimon = try? JSONEncoder().encode(newDigimon) {
                    UserDefaults.standard.set(encodedDigimon, forKey: favoriteKey)
                }
                if let encodedExp = try? JSONEncoder().encode(0.0) {
                    UserDefaults.standard.set(encodedExp, forKey: expKey)
                }
            }
        }
        task.resume()
    }
    func getDigimonName(digimonData: DigimonData) -> String {
        return digimonData.name
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
