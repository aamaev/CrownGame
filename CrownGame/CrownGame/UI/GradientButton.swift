//
//  GradientButton.swift
//  CrownGame
//
//  Created by Артём Амаев on 22.08.24.
//

import SwiftUI

struct GradientButton: View {
    let action: () -> Void
    let title: String
    let width: CGFloat
    let height: CGFloat
    var isActive: Bool?

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Font.custom("BigShouldersStencilDisplay-Bold", size: 20))
                .frame(width: width, height: height)
                .foregroundColor(.white)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "#D93C13"), Color(hex: "#892005")]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                .cornerRadius(4)
                .opacity(isActive ?? true ? 1.0 : 0.3)
        }
    }
}
