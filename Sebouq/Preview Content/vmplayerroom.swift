//
//  File.swift
//  Sebouq
//
//  Created by on 08/08/1445 AH.
//


import Foundation

class PlayerID {
    let id: UUID
    let deviceName: String
    
    init(id: UUID, deviceName: String) {
        self.id = id
        self.deviceName = deviceName
    }
}

class Room {
    let id: String
    var players: [PlayerID] = []

    init(id: String) {
        self.id = id
    }

    func addPlayer(player: PlayerID) {
        players.append(player)
    }

    func removePlayer(playerID: UUID) {
        players.removeAll { $0.id == playerID }
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
