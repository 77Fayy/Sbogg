//
//  Impording.swift
//  Sebouq
//
//  Created by roaa on 25/07/1445 AH.
//

import SwiftUI

struct Impording: View {
    
    @State var selectedPage = 0
    @State private var book = false
    private var showNextView = false
    @State private var navigationActive = false
    
    
    var body: some View {
      
            
            NavigationView{
                ZStack {
                    Image("back")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .ignoresSafeArea()
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
                        Image("ba9")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 430, height: 300)
                            .offset(x: 0, y: 140)
                        Image("research")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 175, height: 191)
                            .offset(x: 0, y:-110)
                        
                    }
                    
                    
                    if selectedPage == 1 {
                        
                    }
                    
                    VStack{
                        NavigationLink(destination:Impording2() ) {
                            Image("b1")
                                .resizable()
                                .frame(width: 300, height: 100)
                                .padding(.top, 400)
                                .aspectRatio(contentMode: .fit)
                                .edgesIgnoringSafeArea(.all)
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                        }
                        
                    }
                    
                    VStack{
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        
                    }
                    
                    
                    
                    
                    
                }
                
                
            }
            
        }
        }
    }

struct Impording_Previews: PreviewProvider {
    static var previews: some View {
        Impording()
    }
}
