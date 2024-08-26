//
//  GameView.swift
//  CrownGame
//
//

import SwiftUI

struct GameView: View {
    @Binding var currentScreen: Screens
    @EnvironmentObject private var stateData: StateData
    
    let gameType: GameType
    
    let dragonLevels: [BetLevel] = [
        BetLevel(multiplier: 0.25, cards: [Card(emoji: Image("lootbox")), Card(emoji: Image("lootbox")), Card(emoji: Image("lootbox")), Card(emoji: Image("sword"))].shuffled()),
        BetLevel(multiplier: 0.50, cards: [Card(emoji: Image("lootbox")), Card(emoji: Image("lootbox")), Card(emoji: Image("sword")), Card(emoji: Image("sword"))].shuffled()),
        BetLevel(multiplier: 0.75, cards: [Card(emoji: Image("lootbox")), Card(emoji: Image("lootbox")), Card(emoji: Image("sword")), Card(emoji: Image("sword"))].shuffled()),
        BetLevel(multiplier: 1.00, cards: [Card(emoji: Image("sword")), Card(emoji: Image("sword")), Card(emoji: Image("sword")), Card(emoji: Image("lootbox"))].shuffled())
    ]
    
    let knightLevels: [BetLevel] = [
        BetLevel(multiplier: 0.50, cards: [Card(emoji: Image("lootbox")), Card(emoji: Image("lootbox")), Card(emoji: Image("lootbox")), Card(emoji: Image("sword"))].shuffled()),
        BetLevel(multiplier: 0.75, cards: [Card(emoji: Image("lootbox")), Card(emoji: Image("lootbox")), Card(emoji: Image("sword")), Card(emoji: Image("sword"))].shuffled()),
        BetLevel(multiplier: 1.00, cards: [Card(emoji: Image("lootbox")), Card(emoji: Image("lootbox")), Card(emoji: Image("sword")), Card(emoji: Image("sword"))].shuffled()),
        BetLevel(multiplier: 1.50, cards: [Card(emoji: Image("sword")), Card(emoji: Image("sword")), Card(emoji: Image("sword")), Card(emoji: Image("lootbox"))].shuffled())
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            Header(buttons: .close, currentScreen: $currentScreen)
            
            HStack(alignment: .center, spacing: 40) {
                switch gameType {
                case .dragonMouth:
                    Game(bet: stateData.bet, levels: dragonLevels, currentScreen: $currentScreen)
                        .padding(.leading, 100)
                case .knight:
                    Game(bet: stateData.bet, levels: knightLevels, currentScreen: $currentScreen)
                        .padding(.leading, 100)
                }
                
                CurrentBank(bet: stateData.bet)
                    .padding(.leading, 25)
            }
        }
    }
}




