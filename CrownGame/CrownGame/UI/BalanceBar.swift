//
//  BalanceBar.swift
//  CrownGame
//
//  Created by Артём Амаев on 22.08.24.
//

import SwiftUI

struct BalanceBar: View {
    let balance: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "#D93C13"), Color(hex: "#892005")]),
                                     startPoint: .leading,
                                     endPoint: .trailing))
                .frame(width: 140, height: 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "502D0E"), lineWidth: 4)
                )
            
            HStack(spacing: 8) {
                Image("coin")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .offset(x: -6)
            
                Text(String(balance))
                    .font(.custom("BigShouldersStencilDisplay-Bold", size: 18))
                    .foregroundColor(.white)
                    .padding(.leading, 4)
                    .shadow(color: Color.yellow.opacity(0.5), radius: 3, x: 0, y: 0)
            }
        }
        .frame(width: 140, height: 30)
    }
}

#Preview {
    BalanceBar(balance: 1000)
}
