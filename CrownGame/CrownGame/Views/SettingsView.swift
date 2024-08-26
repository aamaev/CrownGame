//
//  SettingsView.swift
//  CrownGame
//
//

import SwiftUI
import AVFoundation

struct SettingsView: View {
    @Binding var currentScreen: Screens
    @EnvironmentObject private var stateData: StateData
    @EnvironmentObject private var soundAssistant: SoundAssistant
    
    var body: some View {
        VStack {
            Header(buttons: .close, middleText: "SETTINGS", currentScreen: $currentScreen)
            
            Spacer()
            
            VStack(spacing: 24) {
                GradientButton(action: {
                    soundAssistant.playClickSound()
                    soundAssistant.areSoundsEnabled.toggle()
                }, title: "SOUNDS", width: 180, height: 32, isActive: soundAssistant.areSoundsEnabled)
                
                GradientButton(action: {
                    soundAssistant.playClickSound()
                    soundAssistant.isMusicEnabled.toggle()
                }, title: "MUSIC", width: 180, height: 32, isActive: soundAssistant.isMusicEnabled)
                
                GradientButton(action: {
                    soundAssistant.playClickSound()
                }, title: "VIBRATION", width: 180, height: 32)
            }
            .padding(.bottom, 50)
        }
    }
}


