//
//  WelcomeScreensView.swift
//  CrownGame
//
//

import Foundation
import SwiftUI

struct WelcomeScreensView: View {
    @Binding var currentScreen: Screens
    @EnvironmentObject private var soundAssistant: SoundAssistant
    
    @State private var currentMessageIndex: Int = 0

    let messages = [
        "WELCOME TO THE WORLD OF MEDIEVAL ENTERTAINMENT",
        "YOUR CLOSE ASSISTANTS WILL BE PASSION AND LUCK"
    ]

    var body: some View {
        VStack {
            Text(messages[currentMessageIndex])
                .font(Font.custom("BigShouldersStencilDisplay-Bold", size: 36))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 360)
                .padding()
                .background(
                    Color.black.opacity(0.4)
                )
    
            GradientButton(action: {
                soundAssistant.playClickSound()
                if currentMessageIndex < messages.count - 1 {
                    currentMessageIndex += 1
                } else {
                    currentScreen = .home
                }
            }, title: "CONTINUE", width: 180, height: 32)
        }
    }
}
