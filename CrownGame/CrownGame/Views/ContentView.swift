//
//  ContentView.swift
//  CrownGame
//
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var currentScreen = Screens.launch
    @StateObject private var soundAssistant: SoundAssistant = SoundAssistant()
    @EnvironmentObject private var stateData: StateData
        
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
           Image(stateData.background)
               .resizable()
               .scaledToFill()
               .ignoresSafeArea()
               .layoutPriority(-1)

            VStack {
                switch currentScreen {
                case .launch:
                    LaunchScreenView(currentScreen: $currentScreen)
                case .home:
                    HomeView(currentScreen: $currentScreen)
                case .settings:
                    SettingsView(currentScreen: $currentScreen)
                case .info:
                    InformationView(currentScreen: $currentScreen)
                case .welcomeMessage:
                    WelcomeScreensView(currentScreen: $currentScreen)
                case .gameInfoDragon:
                    GameInfoView(destinationView: .dragonMouthBet, currentScreen: $currentScreen)
                case .gameInfoKnight:
                    GameInfoView(destinationView: .knightSecretBet, currentScreen: $currentScreen)
                case .dragonMouthBet:
                    GameBetView(currentScreen: $currentScreen, gameType: .dragonMouth)
                case .knightSecretBet:
                    GameBetView(currentScreen: $currentScreen, gameType: .knight)
                case .dragonMouthGame:
                    GameView(currentScreen: $currentScreen, gameType: .dragonMouth)
                case .knightSecretGame:
                    GameView(currentScreen: $currentScreen, gameType: .knight)
                }
            }
        }
        .onAppear {
            soundAssistant.playBackgroundMusic()
        }
        .onDisappear {
            soundAssistant.stopBackgroundMusic()
        }
        .environmentObject(soundAssistant)
    }
}


#Preview {
    ContentView()
}
