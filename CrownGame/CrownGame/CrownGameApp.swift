//
//  CrownGameApp.swift
//  CrownGame
//
//

import SwiftUI

@main
struct CrownGameApp: App {
    @StateObject private var stateData = StateData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(stateData)
        }
    }
}
