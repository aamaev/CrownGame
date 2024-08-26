//
//  GameInfoView.swift
//  CrownGame
//
//  Created by Артём Амаев on 22.08.24.
//

import SwiftUI

struct GameInfoView: View {
    var destinationView: Screens
    @Binding var currentScreen: Screens
    @EnvironmentObject private var soundAssistant: SoundAssistant
    @State private var currentMessageIndex: Int = 0

    private let messages = [
        "WELCOME TO DRAGON MOUTH",
        "TO WIN YOU NEED TO BYPASS ALL THE TRAPS GO AS FAR AS POSSIBLE"
    ]

    var body: some View {
        VStack {
            Header(buttons: .close, currentScreen: $currentScreen)
            
            Spacer()
            
            Text(messages[currentMessageIndex])
                .font(Font.custom("BigShouldersStencilDisplay-Bold", size: 36))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 400, height: 100)
                .padding()
                .background(Color.black.opacity(0.4))
                .cornerRadius(8)
                .padding(.bottom, 20)

            GradientButton(action: {
                soundAssistant.playClickSound()
                if currentMessageIndex < messages.count - 1 {
                    currentMessageIndex += 1
                } else {
                    currentScreen = destinationView
                }
            }, title: "CONTINUE", width: 180, height: 32)
            Spacer()

        }
        .padding(.horizontal, 24)
    }
}

