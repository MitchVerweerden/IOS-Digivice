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
        Text(getDigimonDescription())
    }
    
    
    func getDigimonDescription() -> String {
        return details?.descriptions[0].description ?? "Mooi ding"
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView()
    }
}
