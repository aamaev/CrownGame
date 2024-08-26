//
//  LaunchScreenView.swift
//  CrownGame
//
//

import SwiftUI

struct LaunchScreenView: View {
    @Binding var currentScreen: Screens
    @EnvironmentObject private var soundAssistant: SoundAssistant
    @State private var progress: CGFloat = 0.0
    @State private var loadingComplete = false
    private let totalProgress: CGFloat = 1.0
    private let animationDuration: Double = 0.02
    
    @AppStorage("hasSeenWelcomeScreens") private var hasSeenWelcomeScreens: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                if progress >= 0.5 {
                    Image("spear_50")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(x: 38, y: -38)
                }
                
                if progress >= 0.85 {
                    Image("spear_85")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(x: -38, y: -38)

                }
                
                Image("shield")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 30)

            }
            .frame(width: 181, height: 181)
            .padding(.top, 70)

            if loadingComplete {
                Button(action: {
                    soundAssistant.playClickSound()
                    if hasSeenWelcomeScreens {
                        currentScreen = Screens.home
                    } else {
                        currentScreen = Screens.welcomeMessage
                        hasSeenWelcomeScreens = true
                    }
                }) {
                    Text("START")
                        .foregroundColor(.white)
                        .frame(width: 180, height: 32)
                        .font(Font.custom("BigShouldersStencilDisplay-Bold", size: 18))
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(hex: "#D93C13"), Color(hex: "#892005")]),
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        )
                        .cornerRadius(4)
                }
                .transition(.scale)
            } else {
                let barWidth = UIScreen.main.bounds.width * 2 / 3
                
                ZStack {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.black.opacity(0.6))
                            .frame(width: barWidth, height: 30)

                        RoundedRectangle(cornerRadius: 4)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(hex: "#D93C13"), Color(hex: "#892005")]),
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                            .frame(width: barWidth * progress, height: 30)
                    }

                    Text("\(Int(progress * 100))%")
                        .foregroundColor(.white)
                        .font(Font.custom("BigShouldersStencilDisplay-Bold", size: 18))

                    Image("coin")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .offset(x: (barWidth * progress) - (barWidth / 2))
                        .animation(.linear(duration: animationDuration), value: progress)
                }
                .padding()
            }
            Spacer()
        }
        .onAppear {
            startLoading()
        }
    }

    private func startLoading() {
        Timer.scheduledTimer(withTimeInterval: animationDuration / Double(totalProgress), repeats: true) { timer in
            if progress >= totalProgress {
                timer.invalidate()
                withAnimation {
                    loadingComplete = true
                }
            } else {
                progress += 0.01
            }
        }
    }
}







