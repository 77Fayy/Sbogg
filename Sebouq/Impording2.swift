//
//  File.swift
//  Sebouq
//
//  Created by roaa on 25/07/1445 AH.
//

import SwiftUI

struct Impording2: View {
    
    @State var selectedPage = 0
    @State private var book = false
    private var showNextView = false
    @State private var navigationActive = false

 
    
    var body: some View {
        ZStack {
            
      if selectedPage == 0 {
                ZStack {
                    CircleView().offset(x: -100, y: 25)
                 
                    HStack {
                        Image("Vector 8")
                            .offset(x: 50, y: -150)
                            .font(.system(size: 80))
                            .scaleEffect(book ? 1 : 0)
                        
                        Image("Vector 9")
                            .offset(x: -230, y: -150)
                            .font(.system(size: 30))
                            .scaleEffect(book ? 1 : 0)
                            .opacity(book ? 1 : 0)
                    }
                    .animation(.easeOut(duration: 2), value: book)
                    .onAppear {
                        book = true
                    }
                }
                .offset(x: 100, y: -150)
            }
            
            Image("ba99")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 430, height: 300)
                .offset(x: 0, y: 150)
            Image("phone")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 180)
                .offset(x: 0, y:-130)
            
            if selectedPage == 1 {
                
            }
            VStack{
                NavigationLink(destination:
                        group1() ) {
                    Image("s")
                        .resizable()
                        .frame(width: 300, height: 100)
                        .padding(.top, 500)
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.all)
                       
                       
                }
                // Place the NavigationLink outside the
               
            }
            VStack{
                Spacer()
               
            }
            


        }
        
        .background(
            Image("stig3")
                .resizable()
                .padding(.top, -34.0)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        )
    }
}

struct Impording2_Previews: PreviewProvider {
    static var previews: some View {
        Impording2()
    }
}
