//
//  GameBetView.swift
//  CrownGame
//
//

import SwiftUI

struct GameBetView: View {
    @Binding var currentScreen: Screens
    @EnvironmentObject var stateData: StateData
    @EnvironmentObject private var soundAssistant: SoundAssistant
    
    let gameType: GameType
    
    @State private var selectedBetValue: Int? = nil
    
    var body: some View {
        VStack {
            Header(buttons: .close, middleText: "BET'S SIZE", currentScreen: $currentScreen)
            
            Spacer()
            
            HStack(spacing: 10) {
                ForEach(betValues, id: \.self) { value in
                    BetGradientButton(action: {
                        soundAssistant.playClickSound()
                        selectBet(value)
                    }, title: "\(value)", value: value, isSelected: selectedBetValue == value)
                }
            }
            
            Spacer()
            
            GradientButton(action: {
                currentScreen = nextScreen
                soundAssistant.playClickSound()
                stateData.bet = selectedBetValue!
            }, title: "CONTINUE", width: 180, height: 32)
                .padding(.bottom, 30)
                .disabled(selectedBetValue == nil)
                .opacity(selectedBetValue == nil ? 0.5 : 1.0)
        }
    }
    
    private func selectBet(_ value: Int) {
        selectedBetValue = value
    }
    
    private var betValues: [Int] {
        switch gameType {
        case .dragonMouth:
            return [350, 400, 450, 500]
        case .knight:
            return [550, 600, 650, 700]
        }
    }
    
    private var nextScreen: Screens {
        switch gameType {
        case .dragonMouth:
            return .dragonMouthGame
        case .knight:
            return .knightSecretGame
        }
    }
}

struct BetGradientButton: View {
    let action: () -> Void
    let title: String
    let value: Int
    let isSelected: Bool
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Font.custom("BigShouldersStencilDisplay-Bold", size: 20))
                .frame(width: 80, height: 32)
                .foregroundColor(.white)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "#D93C13"), Color(hex: "#892005")]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                .cornerRadius(4)
                .opacity(isSelected ? 0.4 : 1)
        }
    }
}
