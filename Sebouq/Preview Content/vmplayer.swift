//
//  File.swift
//  Sebouq
//
//  Created by fai alradhi on 08/08/1445 AH.
//


import Foundation
import SwiftData

@Model
class playerID {
    let id: UUID
    let deviceName: String
    let playerDate: Date
    
    init(id: UUID, deviceName: String, playerDate: Date) {
        self.id = id
        self.deviceName = deviceName
        self.playerDate = playerDate
    }
    
    

}




//struct PlayerD {
  //  let id: UUID
 //   let deviceName: String
 //   let playerData: Data // Add a property to hold data
    
//    init(deviceName: String, playerData: Data) {
//        self.id = UUID()
//        self.deviceName = deviceName
//        self.playerData = playerData
 //   }
//}//
