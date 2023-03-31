//
//  DescriptionView.swift
//  IOS-Digivice
//
//  Created by Mitchell Verweerden on 30/03/2023.
//

import SwiftUI

struct DescriptionView: View {
    var details: DigimonFullData?
    var body: some View {
            ScrollView {
                VStack{
                    Text(getDigimonDescription())
                        .padding([.horizontal, .vertical], 25)
                        .background(Color("item-background"))
                        .border(Color("description-text"), width: 8)
                        .font(.custom("PixelDigivolve", size: 14))
                        .foregroundColor(Color("description-text"))
                }
            }.edgesIgnoringSafeArea(.top)
    }
    
    
    func getDigimonDescription() -> String {
        if let desc = details?.descriptions.first(where: {$0.language == "en_us"}) {
            return desc.description
        } else {
            return "No description"
        }
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView()
    }
}
