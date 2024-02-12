
import SwiftUI

struct CircleView: View {
    

    @State private var animateCircle: Bool = false
    
    
    var body: some View {
        ZStack {
            Circle().stroke(Color("Color c1"), lineWidth: 40)
                .frame(width: 472, height: 472)
            
            Circle().stroke(Color("Color c2"), lineWidth: 40)
                .frame(width:  402, height:  402 )
            
           Circle().stroke(Color("Color c3"), lineWidth: 40)
               .frame(width:  334, height:  334, alignment: .center)
        }
      // .opacity(animateCircle ? 1: 0)
        //.blur(radius: animateCircle ? 0: 10)
        .scaleEffect(animateCircle ? 1: 0.5)
        .animation(.easeOut(duration: 1.5), value: animateCircle)
        .onAppear(perform: {
            animateCircle = true
        })
        
    }
}

