import SwiftUI

struct FavoriteView: View {
    @Environment(\.verticalSizeClass) var sizeClass
    @State var digimon: DigimonFullData?
    @State var progressValue: Float = 0.0
    @State var buttonText: String = "Train Digimon"
    @State private var digivolveAlert = false
    @State private var editAlert = false
    @State var name: String = ""
    let favoriteKey = "favorite"
    let expKey = "exp"
    var body: some View {
        if sizeClass == .compact {
            HStack {
                DigimonDetails(details: digimon)
                TabView {
                    DescriptionView(details: digimon)
                        .tabItem{
                            Label("Description", systemImage: "books.vertical")
                                .font(.custom("PixelDigivolve", size: 15))
                                .foregroundColor(Color.black)
                        }
                    VStack{
                        ExperienceView(value: $progressValue).frame(height: 20)
                        Button(action: {
                            self.trainDigimon()
                        }) {
                            Text(buttonText)
                        }.padding()
                        Button("Edit Name") {
                            editAlert = true
                        }
                        .alert("Edit Name", isPresented: $editAlert, actions: {
                            TextField("Name", text: $name)
                            Button("Save", action: {
                                saveChanges()
                            })
                        }, message: {
                            Text("Fill in the new name")
                        })
                    }
                    .alert(isPresented: $digivolveAlert,
                           content:{Alert(title:Text("Digimon can't digivolve"))})
                    .tabItem{
                        Label("Actions", systemImage: "network")
                    }
                    
                }.edgesIgnoringSafeArea(.all)
            }.onAppear(perform: loadData)
            
        } else {
            VStack {
                DigimonDetails(details: digimon)
                TabView {
                    DescriptionView(details: digimon)
                        .tabItem{
                            Label("Description", systemImage: "books.vertical")
                                .font(.custom("PixelDigivolve", size: 15))
                                .foregroundColor(Color.black)
                        }
                    VStack{
                        ExperienceView(value: $progressValue).frame(height: 20)
                        Button(action: {
                            self.trainDigimon()
                        }) {
                            Text(buttonText)
                        }.padding()
                        Button("Edit Name") {
                            editAlert = true
                        }
                        .alert("Edit Name", isPresented: $editAlert, actions: {
                            TextField("Name", text: $name)
                            Button("Save", action: {
                                saveChanges()
                            })
                        }, message: {
                            Text("Fill in the new name")
                        })
                    }
                    .alert(isPresented: $digivolveAlert,
                           content:{Alert(title:Text("Digimon can't digivolve")    .font(.custom("PixelDigivolve", size: 15))
                            .foregroundColor(Color.black))})
                    .tabItem{
                        Label("Actions", systemImage: "network")
                    }
                    
                }.edgesIgnoringSafeArea(.all)
                
            }
            .padding()
            .onAppear(perform: loadData)
        }
    
        
    }
    func loadData() {
        // gets digimon and experience from user defailts
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
        //check if progressbar isnt full
        if(self.progressValue < 1){
            
            //add experience
            self.progressValue += 0.19
          
            //save the new experience in UserDefaults
            if let encoded = try? JSONEncoder().encode(self.progressValue) {
                UserDefaults.standard.set(encoded, forKey: expKey)
            }
            //If the progresbar is full change the text to Digivolve because the same button will do somehting else
            if(self.progressValue > 1){
                self.buttonText = "Digivolve"
            }
            
        }else{
            //if the progressbar is full check if the current digimon has Next evolutions
            if let hasNoNextEvolutions = digimon?.nextEvolutions.isEmpty, hasNoNextEvolutions {
                digivolveAlert = true
            } else {
                //if the current digimon does infact have a next evolution, generate a random id from the list and digivolve that digimon
                guard let evolutionsLength = self.digimon?.nextEvolutions.count else { return  }
                let randomInt = Int.random(in: 0..<evolutionsLength)
                digivolve(digimonId: self.digimon?.nextEvolutions[randomInt].id ?? 1)
            }
            
        }
        
    }
    func digivolve(digimonId: Int){
        //when a digimon has enough experience it will digivolve ie change to another digimon
        var newDigimon: DigimonFullData?
        
        //get new digimon from api
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
                //decode the api return
                newDigimon = try
                JSONDecoder().decode(DigimonFullData.self, from: data)
            } catch let error as NSError {
                print("Error: decoding. In domain= \(error.domain), description= \(error.localizedDescription)")
            }
            if newDigimon == nil {
                print("Error: failed to read or decode data.")
            }
            DispatchQueue.main.async {
                //save new digimon in UserDefaults
                if let encodedDigimon = try? JSONEncoder().encode(newDigimon) {
                    UserDefaults.standard.set(encodedDigimon, forKey: favoriteKey)
                }
                if let encodedExp = try? JSONEncoder().encode(0.0) {
                    UserDefaults.standard.set(encodedExp, forKey: expKey)
                }
                //loadData again so the current digimon is updated
                loadData()
            }
        }
        task.resume()
        //change button text because the new digimon has 0 experience
        self.buttonText = "Train Digimon"
    }
    func saveChanges(){
        //save the name change of the digimon to UserDefaults
        self.digimon?.name = name
        if let encodedDigimon = try? JSONEncoder().encode(self.digimon) {
            UserDefaults.standard.set(encodedDigimon, forKey: favoriteKey)
        }
    }
    
}
