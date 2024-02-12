//
//  ContentView.swift
//  Sebouq
//
//  Created by roaa on 25/07/1445 AH.
//

import SwiftUI


struct Splach: View {
    @State private var isActive=false
    @State private var size = 0.7
   @State private var opacity = 0.5
    var body: some View {
        FinalView()
    }
}


struct Splach_Previews: PreviewProvider {
    static var previews: some View {
        splach()
        
    }
}
struct FinalView: View {
    @State var splashScreen  = true

    var body: some View {
        ZStack{
            Image("Stig")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .frame(width: 400 , height: 300)
            
       
            Group{
              if splashScreen {
                  SplashScreen()
               }
              else{
                  Impording()
                    }
                }
               .onAppear {
                  DispatchQueue
                       .main
                       .asyncAfter(deadline:
                            .now() + 3.5) {
                   splashScreen = false
                  }
                }
            }
        }
    }



struct SplashScreen: View {
    @State private var animateOffset = false
    @State private var book = false
    var body: some View {
       
            
            
        ZStack{
            // هنا عدلت الارقام
            CircleView().offset(x: -7, y: 85)

            HStack{
                Image("Vector 8")
                    .offset(x:50, y: -150)
                
                    .font(.system(size: 80))
                    .scaleEffect(book ? 1 : 0)
                
                Image( "Vector 9")
                    .offset(x:-230, y: -150)
                
                    .font(.system(size: 30))
                    .scaleEffect(book ? 1 : 0)
                    .opacity(book ? 1 : 0)
            }
            .animation(.easeOut(duration: 2), value: book)
            .onAppear(perform: {
                book = true
            })
            .offset(x: 100, y: -30)
            ZStack {
                Image("logo")
                    .resizable()
                    .frame(width: 300, height: 400)
                    .offset(x: -120, y: animateOffset ? 190 : 400)
            }
            
            
            .offset(x: 100, y: -170)
            .animation(.easeOut(duration: 2), value: animateOffset)
            .onAppear {
                animateOffset = true
            }}
        
            Image("stig1")
            .padding(.bottom, 0)
            

            }

        }
