//
//  ContentView.swift
//  IOS-Digivice
//
//  Created by Mitchell Verweerden on 22/03/2023.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true)) {
                
                ZStack{
                    Image("background2").resizable()
                        .ignoresSafeArea(.all)
                        .scaledToFill()
                    VStack {
                    Image("Digimon-Logo")
                    Text("Tap anywhere to continue")
                        .font(.custom("PixelDigivolve", size: 20))
                        .foregroundColor(.orange)
                }
                .padding()
                }
            }
            
           
        }
     
    }
    
    init(){
        for familyName in UIFont.familyNames{
            print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName){
                print("-- \(fontName) ")
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
