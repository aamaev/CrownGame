//
//  HomeView.swift
//  CrownGame
//
//

import SwiftUI
import AVFoundation

struct HomeView: View {
    @Binding var currentScreen: Screens
    @EnvironmentObject private var stateData: StateData
    @EnvironmentObject private var soundAssistant: SoundAssistant
    
    var body: some View {
        VStack {
            Header(buttons: .settingsInfo, currentScreen: $currentScreen)

            Spacer()

            HStack(spacing: 48) {
                MenuImageButton(action: {
                    soundAssistant.playClickSound()
                    currentScreen = Screens.gameInfoDragon
                    stateData.changeBackground(bg: "dragon_background")
                }, imageName: "dragon", title: "DRAGON MOUTH")
                MenuImageButton(action: {
                    soundAssistant.playClickSound()
                    currentScreen = Screens.gameInfoKnight
                    stateData.changeBackground(bg: "knight_background")
                }, imageName: "knight", title: "KNIGHT'S SECRET")
            }
            .padding(.bottom, 50)
        }
    }
}



