//
//  vmRoom.swift
//  Sebouq
//
//  Created by fai alradhi on 05/08/1445 AH.
//
import SwiftUI

class Roomm: ObservableObject {
let id: UUID
@Published var players: [Player]

init() {
    self.id = UUID()
    self.players = []
}

func addPlayer(_ player: Player) {
    players.append(player)
}

func removePlayer(_ player: Player) {
    if let index = players.firstIndex(where: { $0.id == player.id }) {
        players.remove(at: index)
    }
}
}


