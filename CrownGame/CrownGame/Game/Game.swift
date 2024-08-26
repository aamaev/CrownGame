//
//  Game.swift
//  CrownGame
//
//

import SwiftUI
import AVFoundation

struct BetLevel {
    let multiplier: Double
    var cards: [Card]
}

struct Card: Identifiable {
    let id = UUID()
    let emoji: Image
    var isRevealed = false
}

struct Game: View {
    var bet: Int
    @State private var levels: [BetLevel]
    
    @Binding var currentScreen: Screens
    @EnvironmentObject private var stateData: StateData
    @EnvironmentObject private var soundAssistant: SoundAssistant

    @State private var unlockedLevels: Int = 1
    @State private var gameOver = false
    @State private var currentLevel: Int?
    @State private var finalAmount: Int = 0
    @State private var isWin: Bool = false
    
    public init(bet: Int, levels: [BetLevel], currentScreen: Binding<Screens>) {
        self.bet = bet
        self._levels = State(initialValue: levels)
        self._currentScreen = currentScreen
    }

    var body: some View {
        HStack {
            VStack(spacing: 10) {
                ForEach(Array(levels.enumerated().reversed()), id: \.offset) { index, level in
                    HStack {
                        Text("X \(String(format: "%.2f", level.multiplier))")
                            .font(.custom("BigShouldersStencilDisplay-Bold", size: 26))
                            .foregroundColor(.white)
                            .frame(width: 80, alignment: .trailing)
                        
                        ForEach(0..<4, id: \.self) { cardIndex in
                            if index < unlockedLevels {
                                CardView(card: level.cards[cardIndex])
                                    .onTapGesture {
                                        if !gameOver && !level.cards[cardIndex].isRevealed {
                                            currentLevel = index
                                            revealCard(levelIndex: index, cardIndex: cardIndex)
                                        }
                                    }
                            } else {
                                LockedCardView()
                            }
                        }
                    }
                }
        
            }
            ZStack {
                Color.clear
                    .frame(width: 80, height: 32)
                    
                if currentLevel != nil {
                    GradientButton(action: {
                        soundAssistant.playClickSound()
                        if !gameOver {
                            gameOver = true
                            isWin = true
                            calculateFinalAmount(isWin: isWin)
                            if let currentLevel = currentLevel {
                                checkForCompletion(in: currentLevel)
                            }
                        }
                    }, title: "FINISH", width: 80, height: 32)
                }
            }
        }
        .onAppear {
            stateData.changeBalance(by: -bet)
        }
        .sheet(isPresented: $gameOver) {
            FinishWindow(isWin: isWin, amount: finalAmount, currentLevel: currentLevel.map { levels[$0].multiplier }, currentScreen: $currentScreen)
        }
    }
    
    func revealCard(levelIndex: Int, cardIndex: Int) {
         levels[levelIndex].cards[cardIndex].isRevealed = true
         
         if levels[levelIndex].cards[cardIndex].emoji == Image("sword") {
             isWin = false
             gameOver = true
             stateData.changeBalance(by: -bet)
         } else {
             isWin = true
             let winnings = Float(bet) * Float(levels[levelIndex].multiplier)
             finalAmount = Int(bet) + Int(winnings)
             stateData.bet = finalAmount
             checkForCompletion(in: levelIndex)
         }
     }
     
    func checkForCompletion(in levelIndex: Int) {
         let revealedLootbox = levels[levelIndex].cards.contains(where: { $0.isRevealed && $0.emoji == Image("lootbox") })
         if revealedLootbox && !gameOver {
             if levelIndex + 1 < levels.count {
                 unlockedLevels = max(unlockedLevels, levelIndex + 2)
             } else {
                 isWin = true
                 gameOver = true
                 calculateFinalAmount(isWin: isWin)
             }
         }
     }

    private func calculateFinalAmount(isWin: Bool) {
        if isWin {
            stateData.changeBalance(by: finalAmount)
        }
    }
}

struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            Rectangle()
                .fill(card.isRevealed ? Color(hex: "892005") : Color(hex: "D93C13"))
                .frame(width: 60, height: 60)
                .cornerRadius(8)
            
            if card.isRevealed {
                card.emoji.resizable().scaledToFit().frame(width: 55, height: 55)
            }
        }
    }
}

struct LockedCardView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(hex: "D93C13"))
                .frame(width: 60, height: 60)
                .cornerRadius(8)
            
            Image("lock")
                .resizable()
                .scaledToFit()
                .frame(width: 55, height: 55)
        }
    }
}

struct FinishWindow: View {
    let isWin: Bool
    let amount: Int?
    let currentLevel: Double?
    @Binding var currentScreen: Screens
    @EnvironmentObject private var stateData: StateData
    @EnvironmentObject private var soundAssistant: SoundAssistant
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
           Image(stateData.background)
               .resizable()
               .scaledToFill()
               .ignoresSafeArea()
               .layoutPriority(-1)
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                
            VStack {
                if isWin {
                    Text("YOU WIN!")
                        .font(.custom("BigShouldersStencilDisplay-Bold", size: 36))
                        .foregroundColor(.white)
                        .frame(width: 200)
                    HStack {
                        Image("coin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 118, height: 118)
                        Text(String(amount!))
                            .font(.custom("BigShouldersStencilDisplay-Bold", size: 44))
                            .foregroundColor(.white)
                    }
                } else {
                    Text("YOU LOSE!")
                        .font(.custom("BigShouldersStencilDisplay-Bold", size: 36))
                        .foregroundColor(.white)
                        .frame(width: 200)
                }
                
                Button(action: {
                    soundAssistant.playClickSound()
                    currentScreen = .home
                }) {
                    Text("GO TO MENU")
                        .font(Font.custom("BigShouldersStencilDisplay-Bold", size: 24))
                        .frame(width: 180, height: 32)
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(hex: "#D93C13"), Color(hex: "#892005")]),
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        )
                        .cornerRadius(4)
                }
            }
        }
        .onAppear {
            if isWin {
                soundAssistant.playVictorySound()
            } else {
                soundAssistant.playDefeatSound()
            }
        }
    }
}






