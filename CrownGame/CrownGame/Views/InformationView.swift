//
//  InformationView.swift
//  CrownGame
//
//

import SwiftUI

struct InformationView: View {
    @Binding var currentScreen: Screens
    @EnvironmentObject private var soundAssistant: SoundAssistant
        
    var body: some View {
        VStack {
            Header(buttons: .close, middleText: "INFORMATION", currentScreen: $currentScreen)
            
            Spacer()

            VStack(spacing: 24) {
                GradientButton(action: {
                    soundAssistant.playClickSound()
                }, title: "TERMS OF USE", width: 180, height: 32)
                
                GradientButton(action: {
                    soundAssistant.playClickSound()
                }, title: "POLICY", width: 180, height: 32)
                
                GradientButton(action: {
                    soundAssistant.playClickSound()
                }, title: "CONTACTS", width: 180, height: 32)
            }
        }
    }
}



