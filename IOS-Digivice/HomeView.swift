//
//  HomeView.swift
//  IOS-Digivice
//
//  Created by Mitchell Verweerden on 22/03/2023.
//

import SwiftUI

struct HomeView: View {
    @State var digimonData: DigimonData?
    var body: some View {
        VStack {
            Text(getDigimonName())
        }.onAppear(perform: loadData)
    }
    
    func loadData() {
        var newDigimonData: DigimonData?
        guard let url = URL(string: "https://www.digi-api.com/api/v1/digimon/agumon")
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
                newDigimonData = try
                JSONDecoder().decode(DigimonData.self, from: data)
            } catch let error as NSError {
                print("Error: decoding. In domain= \(error.domain), description= \(error.localizedDescription)")
            }
            if newDigimonData == nil {
                print("Error: failed to read or decode data.")
            }
            DispatchQueue.main.async {
                self.digimonData = newDigimonData
            }
        }
        task.resume()
    }
    
    func getDigimonName() -> String {
        return digimonData?.name ?? "niks lol"
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
