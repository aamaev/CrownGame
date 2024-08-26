//
//  MenuImageButton.swift
//  CrownGame
//
//  Created by Артём Амаев on 22.08.24.
//

import SwiftUI

struct MenuImageButton: View {
    let action: () -> Void
    let imageName: String
    let title: String

    var body: some View {
        Button(action: action) {
            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                Text(title)
                    .font(Font.custom("BigShouldersStencilDisplay-Bold", size: 14))
                    .foregroundColor(.white)
                    .shadow(color: Color.yellow.opacity(0.5), radius: 4, x: 0, y: 0)
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(hex: "#D93C13"), Color(hex: "#892005")]),
                               startPoint: .leading,
                               endPoint: .trailing)
            )
            .cornerRadius(4)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.white, lineWidth: 2)
            )
            .shadow(color: Color(hex: "#892005").opacity(0.5), radius: 6, x: 0, y: 0)
        }
    }
}
