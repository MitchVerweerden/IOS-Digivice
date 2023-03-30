
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
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
