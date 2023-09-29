//
//  MainButtonStyle.swift
//  Client
//
//  Created by Emma Gaubert on 26/09/2023.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.title2, design: .rounded ))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.orange)
            )
            .padding([.bottom, .top], 5)
            .padding([.leading, .trailing], 30)
    }
}
