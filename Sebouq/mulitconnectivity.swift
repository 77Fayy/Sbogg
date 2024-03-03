//
//  Sharing.swift
//  Sebouq
//
//  Created by roaa on 25/07/1445 AH.
//

import SwiftUI
import MultipeerConnectivity
import Combine

class MultipeerManager: NSObject, ObservableObject, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate {
    @Published var errorMessage: ErrorMessage?
    
    struct ErrorMessage: Identifiable {
        let id = UUID()
        let message: String
    }
    
    @Published var receivedGameData: String = ""
    @Published var connectedPeers: [MCPeerID] = []
    @Published var isSelectingPeers = false
    @Published var isGameStarted = false
    @Published var selectedPeers: [MCPeerID] = []
    
    var myPeerID = MCPeerID(displayName: UIDevice.current.name)
    var session: MCSession?
    var advertiser: MCNearbyServiceAdvertiser?
    var browser: MCNearbyServiceBrowser?
    
    override init() {
        super.init()
        session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .required)
        session?.delegate = self
        startAdvertising()
        startBrowsing()
    }
    
    func startAdvertising() {
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: "Players")
        advertiser?.delegate = self
        advertiser?.startAdvertisingPeer()
    }
    
    func startBrowsing() {
        browser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: "Players")
        browser?.delegate = self
        browser?.startBrowsingForPeers()
    }
    
    func sendPlayerName(playerName: String, toPeer peer: MCPeerID) {
        guard let session = session else { return }
        
        do {
            let data = "\(playerName)".data(using: .utf8)!
            try session.send(data, toPeers: [peer], with: .reliable)
        } catch {
            errorMessage = ErrorMessage(message: "Error sending player name: \(error.localizedDescription)")
        }
    }
    
    func handleGameUpdate(_ data: String) {
        // Implement logic to handle game-related data
    }
    
    // MARK: - MCSessionDelegate
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print("Connection state changed with peer \(peerID.displayName). New state: \(state.rawValue)")
        
        if state == .connected {
            connectedPeers.append(peerID)
        } else if state == .notConnected, let index = connectedPeers.firstIndex(of: peerID) {
            connectedPeers.remove(at: index)
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let receivedString = String(data: data, encoding: .utf8) {
            print("Received data from \(peerID.displayName): \(receivedString)")
            
            DispatchQueue.main.async {
                self.receivedGameData = receivedString
            }
            
            handleGameUpdate(receivedString)
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // Handle received stream
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // Handle start receiving resource
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // Handle finish receiving resource
    }
    
    // MARK: - MCNearbyServiceAdvertiserDelegate
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, self.session)
    }
    
    // MARK: - MCNearbyServiceBrowserDelegate
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        browser.invitePeer(peerID, to: self.session!, withContext: nil, timeout: 30)
    }
    
    func invitePeer(_ peer: MCPeerID) {
        guard let session = session else {
            errorMessage = ErrorMessage(message: "Error: No session available.")
            return
        }
        browser?.invitePeer(peer, to: session, withContext: nil, timeout: 30)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        invitePeer(peerID)
        // Handle when a nearby peer is lost
    }
}

struct PeerListView: View {
    @ObservedObject var multipeerManager: MultipeerManager
    @Binding var playerName: String // To store player name input
    
    var body: some View {
        VStack {
            List(multipeerManager.connectedPeers, id: \.self) { peerID in
                Text(peerID.displayName)
            }
            
            TextField("Enter player name", text: $playerName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Join Game") {
                
                multipeerManager.selectedPeers.append(contentsOf: multipeerManager.connectedPeers)
                playerName = "" // Reset player name input
            }
        }
    }
}

struct ReceivedGameDataView: View {
    @ObservedObject var multipeerManager: MultipeerManager
    
    var body: some View {
        HStack {
            Image("أسماء اللاعبين") // Replace "yourPlayersImageName" with the actual name of your image in the assets
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140) // Adjust the size as needed
            // Adjust the trailing padding as needed
            
            Text("\(multipeerManager.receivedGameData)")
                .padding()
        }
    }
}


/*
struct Sharing1: View {
    @ObservedObject var multipeerManager = MultipeerManager()
    @State private var playerName = ""
    @State private var errorMessage: String?
    @State private var room: Room?
    @State private var createdRoom: Room?
    
    var body: some View {
        VStack {
            Button(action: {}) {
                Image("settings")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            }
            
            Image("dvice")
                .padding()
            
            PeerListView(multipeerManager: multipeerManager, playerName: $playerName)
                .frame(width: 300, height: 300)
                .background(Color.white)
                .cornerRadius(10)
            
            ReceivedGameDataView(multipeerManager: multipeerManager)
            
            if let room = room {
                Text("You are in Room \(room.id)")
                Button("Leave Room") {
                    guard let playerID = room.players.first(where: { $0.deviceName == UIDevice.current.name })?.id else {
                        return
                    }
                    RoomManager.shared.leaveRoom(playerID: playerID)
                    self.room = nil
                }
            } else {
                Button("Create Room") {
                    self.createdRoom = RoomManager.shared.createRoom() // Store the created room
                    let playerID = PlayerID(id: UUID(), deviceName: UIDevice.current.name)
                    RoomManager.shared.joinRoom(player: playerID)
                    self.room = self.createdRoom // Assign the created room to the current room
                }
            }
            
            if !multipeerManager.isSelectingPeers && !multipeerManager.isGameStarted {
                Button(action: {
                    multipeerManager.isSelectingPeers = true
                }) {
                    Image("اصحابك")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 50)
                }
            }
            
            if multipeerManager.isSelectingPeers && !multipeerManager.isGameStarted {
                PeerListViewForSelection(multipeerManager: multipeerManager, playerName: $playerName)
                
                Button(action: {
                    multipeerManager.selectedPeers.forEach { selectedPeer in
                        multipeerManager.sendPlayerName(playerName: playerName, toPeer: selectedPeer)
                    }
                    multipeerManager.isSelectingPeers = false
                    multipeerManager.isGameStarted = true
                }) {
                    NavigationLink(destination: Timer1()) {
                        Image("ابدا")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 50)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }
                }
            }
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            if multipeerManager.isGameStarted {
                // Additional game content goes here
            }
        }
        .padding()
        .background(
            Image("back")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
        .onReceive(Just(multipeerManager.errorMessage)) { message in
            self.errorMessage = message?.message
        }
    }
}
*/


struct PeerListViewForSelection: View {
    @ObservedObject var multipeerManager: MultipeerManager
    @Binding var playerName: String
    var body: some View {
        List {
            ForEach(multipeerManager.connectedPeers, id: \.self) { peerID in
                let isSelected = multipeerManager.selectedPeers.contains(peerID)
                
                Button(action: {
                    if isSelected {
                        if let index = multipeerManager.selectedPeers.firstIndex(of: peerID) {
                            multipeerManager.selectedPeers.remove(at: index)
                        }
                    } else {
                        multipeerManager.selectedPeers.append(peerID)
                    }
                }) {
                    Text(peerID.displayName)
                        .foregroundColor(isSelected ? .blue : .black)
                }
            }
        }
    }
}

struct Sharing_Previews: PreviewProvider {
    static var previews: some View {
        Sharing()
    }
}
