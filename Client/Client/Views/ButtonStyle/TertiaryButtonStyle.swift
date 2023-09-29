//
//  TertiaryButtonStyle.swift
//  Client
//
//  Created by Emma Gaubert on 26/09/2023.
//

import SwiftUI

struct TertiaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.callout, design: .rounded ))
            .fontWeight(.regular)
            .foregroundColor(.white)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.orange)
            )
            .padding([.bottom, .top], 5)
            .padding([.leading, .trailing], 15)
    }
}
