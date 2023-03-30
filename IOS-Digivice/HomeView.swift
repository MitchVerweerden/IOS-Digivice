import SwiftUI

struct HomeView: View {
    @State var digimonList: [DigimonData]?
    var body: some View {
        NavigationView {
            List {
                ForEach(digimonList ?? [], id: \DigimonData.id) {digimon in
                    NavigationLink(destination: DigimonListItem(digimon: digimon)) {
                        DigimonListItem(digimon: digimon)
                    }
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
    
    func getDigimonName(digimonData: DigimonData) -> String {
        return digimonData.name
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}