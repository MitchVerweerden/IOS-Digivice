import SwiftUI

struct FavoriteView: View {
    @State var digimon: DigimonFullData?
    @State var progressValue: Float = 0.0
    @State var buttonText: String = "Train Digimon"
    let favoriteKey = "favorite"
    let expKey = "exp"
    var body: some View {
        VStack {
            Text(self.digimon?.name ?? "leeg")
            ExperienceView(value: $progressValue).frame(height: 20)
            Button(action: {
                self.trainDigimon()
            }) {
                Text(buttonText)
            }.padding()
        }
        .padding()
        .onAppear(perform: loadData)
    }
    func loadData() {
        if let digimonData = UserDefaults.standard.object(forKey: favoriteKey) as? Data,
           let newDigimon = try? JSONDecoder().decode(DigimonFullData.self, from: digimonData) {
            self.digimon = newDigimon
        }
        if let expData = UserDefaults.standard.object(forKey: expKey) as? Data,
           let experience = try? JSONDecoder().decode(Float.self, from: expData) {
            self.progressValue = experience
            
        }
    }
    func trainDigimon() {
        if(self.progressValue < 1){
            for _ in 0...10 {
                self.progressValue += 0.020
            }
            if let encoded = try? JSONEncoder().encode(self.progressValue) {
                UserDefaults.standard.set(encoded, forKey: expKey)
            }
            if(self.progressValue > 1){
                self.buttonText = "Digivolve"
            }
            
        }else{
            digivolve(digimonId: self.digimon?.nextEvolutions[0].id ?? 1)
        }
      
    }
    func digivolve(digimonId: Int){
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
                loadData()
            }
        }
        task.resume()
        self.buttonText = "Train"
    }
    
    struct FavoriteView_Previews: PreviewProvider {
        static var previews: some View {
            FavoriteView()
        }
    }
}
