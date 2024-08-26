//
//  HeaderView.swift
//  CrownGame
//
//  Created by Артём Амаев on 22.08.24.
//

import SwiftUI

struct Header: View {
    var buttons: HeaderButtons
    var middleText: String?
    
    @Binding var currentScreen: Screens
    @EnvironmentObject private var soundAssistant: SoundAssistant
    @EnvironmentObject private var stateData: StateData
    
    var body: some View {
        HStack {
            // Left Side Buttons
            HStack(spacing: 16) {
                switch buttons {
                case .close:
                    SmallGradientButton(action: {
                        soundAssistant.playClickSound()
                        currentScreen = .home
                    }, imageName: "close")
                case .settingsInfo:
                    SmallGradientButton(action: {
                        soundAssistant.playClickSound()
                        currentScreen = .settings
                    }, imageName: "settings")
                    SmallGradientButton(action: {
                        soundAssistant.playClickSound()
                        currentScreen = .info
                    }, imageName: "info")
                }
            }

            Spacer()

            // Middle Text with Fixed Width
            if let text = middleText {
                Text(text)
                    .font(Font.custom("BigShouldersStencilDisplay-Bold", size: 36))
                    .foregroundColor(.white)
                    .padding(10)
                    .background(
                        Color.black.opacity(0.4)
                            .cornerRadius(8)
                    )
                    .frame(maxWidth: 250, alignment: .center) // Fixed width, centered
                    .lineLimit(1) // Limit to a single line
                    .truncationMode(.tail) // Truncate text if too long
            }

            Spacer()

            // Right Side Balance
            BalanceBar(balance: stateData.balance)
        }
        .frame(height: 50)
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(Color.black.opacity(0.8))
    }
}

