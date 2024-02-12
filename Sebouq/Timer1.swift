//
//  Timer.swift
//  Sebouq
//
//  Created by roaa on 25/07/1445 AH.
//

import SwiftUI
import AVFAudio

struct Timer: View {
    @State private var isActive=false
    @State private var size = 0.7
    @State private var opacity = 0.5
    @State private var isSittingSheetPresented = false
    @State private var isSoundOn = true
    @State private var
    isSheetPresented = false
    @State private var remainingTime: Int = 5
    @State private var animateCircle: Bool = false
    var body: some View {
        if isActive {
            Camera1()
        } else {
            
            ZStack {
                Image("ti")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .ignoresSafeArea()
                HStack{
                    Spacer()
                    Spacer()
                    
                    
                    
                    
                    Button(action: {
                        isSittingSheetPresented.toggle()
                    }) {
                        Image("settings")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .padding(.bottom,725)
                            .sheet(isPresented: $isSittingSheetPresented) {
                                Sitting()
                            }
                    }
                    
                }
                
                VStack{
                    Spacer()
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                Image("camel")
                    .position(x: 70, y: 180)
                
                //هنا حطيت كود وفوق التعريف حقه
                
                ZStack {
                    //
                    
                    Circle().stroke(Color("Color c3"), lineWidth: 16)
                        .frame(width:  180, height:  180 )
                    
                    Circle().stroke(Color("Color c2"), lineWidth: 16)
                        .frame(width: 150, height: 150, alignment: .center)
                    Circle().stroke(Color("Color c1"), lineWidth: 16)
                        .frame(width: 125, height: 125)
                }
                // .opacity(animateCircle ? 1: 0)
                //.blur(radius: animateCircle ? 0: 10)
                .scaleEffect(animateCircle ? 1: 0.5)
                .animation(.easeOut(duration: 1.5), value: animateCircle)
                .onAppear(perform: {
                    animateCircle = true
                })
                
                
                
                
                Image("timer")
                    .resizable()
                    .frame(width: 190, height: 190)
                
                
                
                
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.gray)
                    .background(Circle().fill(.white))
                //  .opacity(0.3)
                    .frame(width: 110, height: 350)
                // .padding(.bottom               , 0)
                
                
                
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(Double(remainingTime) / 10.0, 1.0)))
                
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .foregroundColor(Color("Colorred"))
                    .rotationEffect(Angle(degrees: 270.0))
                    .frame(width: 110, height: 350)
                    .padding(.bottom               , 0)
                
                
                Spacer().onAppear {
                    print("Playing sound automatically!")
                    SoundManager.playSound(sound: "timer", type: "mp3")
                }
                
                Text("\(remainingTime)")
                
                    .font(.title)
                    .fontWeight(.bold)
                
            }
            
            .onAppear {
                _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    if remainingTime > 0 {
                        remainingTime -= 1
                    } else {
                        Camera1()
                    }
                }
            }
            
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
                
                
                
                
            }
            .onDisappear {
                SoundManager.stopAudio()  // Stop the audio when the view disappears
            }
        }
    }
    class SoundManager {
        static var audioPlayer: AVAudioPlayer?
        
        static func playSound(sound: String, type: String) {
            if let path = Bundle.main.path(forResource: sound, ofType: type) {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                    audioPlayer?.play()
                } catch {
                    print("Error playing sound: \(error.localizedDescription)")
                }
            }
        }
        
        static func stopAudio() {
            audioPlayer?.stop()
        }
    }
    
}
    
#if DEBUG
    
    struct Timer_Previews: PreviewProvider {
        static var previews: some View {
            Timer()
            
        
        }
    }
    
#endif
