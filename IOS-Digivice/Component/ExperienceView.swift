
import SwiftUI

struct ExperienceView: View {
    @Binding var value: Float
      
    var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                    
                    Rectangle()
                        .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color(UIColor.systemBlue))
                        .onAppear {
                            withAnimation(.linear) {
                                
                            }
                        }
                }.cornerRadius(45.0)
            }
        }
}

