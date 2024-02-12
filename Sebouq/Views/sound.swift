//
//  sounds.swift
//  MC3
//
//  Created by Reem Alhalafi on 13/07/1445 AH.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?


func playsound(sound: String, type: String) {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print(" erro find the sound")
        }
    }
        
}
func stopAudio() {
    audioPlayer?.stop()
    audioPlayer = nil
}
