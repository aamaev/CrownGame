//
//  SmallGradientButton.swift
//  CrownGame
//
//  Created by Артём Амаев on 22.08.24.
//

import SwiftUI

struct SmallGradientButton: View {
    let action: () -> Void
    let imageName: String

    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "#D93C13"), Color(hex: "#892005")]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                .cornerRadius(4)
        }
    }
}
