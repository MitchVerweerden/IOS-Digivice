

import SwiftUI

struct FavoriteView: View {
    @State var digimon: DigimonFullData?
    var body: some View {
      
        VStack{
            Text(digimon?.name ?? "Leeg")
        }.onAppear(perform: loadData)
       
    }
    func loadData() {
        var newDigimon: DigimonFullData?
        
        guard let url = URL(string: "https://digimon-api.com/api/v1/digimon/1")
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
                self.digimon = newDigimon
            }
        }
        task.resume()
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
