//
//  CurrentBank.swift
//  CrownGame
//
//  Created by Артём Амаев on 22.08.24.
//

import SwiftUI

struct CurrentBank: View {
    let bet: Int
    
    var body: some View {
        VStack {
            Text("BANK")
                .font(Font.custom("BigShouldersStencilDisplay-Bold", size: 24))
                .foregroundColor(.white)
                .shadow(color: Color.yellow.opacity(0.5), radius: 4, x: 0, y: 0)
            
            ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "#D93C13"), Color(hex: "#892005")]),
                                     startPoint: .leading,
                                     endPoint: .trailing))
                .frame(width: 140, height: 32)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "502D0E"), lineWidth: 4)
                )
            Text(String(bet))
                .font(.custom("BigShouldersStencilDisplay-Bold", size: 18))
                .foregroundColor(.white)
                .padding(.leading, 4)
                .shadow(color: Color.yellow.opacity(0.5), radius: 3, x: 0, y: 0)
            }
            .frame(width: 140, height: 32)
        }
    }
}
