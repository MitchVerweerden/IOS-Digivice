import SwiftUI

struct DetailView: View {
    @State var digimonId: Int
    @State var details: DigimonFullData?
    @Environment(\.verticalSizeClass) var sizeClass
    var body: some View {
        if sizeClass == .compact {
            HStack {
                DigimonDetails(details: details)
                TabView {
                    DescriptionView(details: details)
                        .tabItem{
                            Label("Description", systemImage: "books.vertical")
                        }.toolbarBackground(Color("item-background"), for: .automatic)
                    DescriptionButtonView(details: details)
                        .tabItem{
                            Label("Actions", systemImage: "exclamationmark")
                        }.toolbarBackground(Color("item-background"), for: .automatic)
                }.edgesIgnoringSafeArea(.all)
            }.onAppear(perform: loadData)
            
        } else {
            VStack {
                DigimonDetails(details: details)
                
                TabView {
                    DescriptionView(details: details)
                        .tabItem{
                            Label("Description", systemImage: "books.vertical")
                        }.toolbarBackground(Color("item-background"), for: .automatic)
                    DescriptionButtonView(details: details)
                        .tabItem{
                            Label("Actions", systemImage: "exclamationmark")
                        }.toolbarBackground(Color("item-background"), for: .automatic)
                }.edgesIgnoringSafeArea(.all)
                    
            }.onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        var newDetails: DigimonFullData?
        guard let url = URL(string: "https://www.digi-api.com/api/v1/digimon/" + String(digimonId) )
        else {
            print("Error: failed to construct a URL from string")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data ,
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
                newDetails = try
                JSONDecoder().decode(DigimonFullData?.self, from: data)
            } catch let error as NSError {
                print("Error: decoding. In domain= \(error.domain), description= \(error.localizedDescription)")
            }
            if newDetails == nil {
                print("Error: failed to read or decode data.")
            }
            DispatchQueue.main.async {
                self.details = newDetails
            }
        }
        task.resume()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(digimonId: 4)
    }
}
