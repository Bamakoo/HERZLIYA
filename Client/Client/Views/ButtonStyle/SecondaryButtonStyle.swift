//
//  SecondaryButtonStyle.swift
//  Client
//
//  Created by Emma Gaubert on 26/09/2023.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.title3, design: .rounded))
            .fontWeight(.regular)
            .foregroundColor(.orange)
            .padding(20)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.orange, lineWidth: 5)
            )
            .padding([.bottom, .top], 5)
            .padding([.leading, .trailing], 40)
    }
}
