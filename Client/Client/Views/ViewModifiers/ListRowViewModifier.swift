//
//  ListRowViewModifier.swift
//  Client
//
//  Created by Emma Gaubert on 25/09/2023.
//

import SwiftUI

struct ListRowViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color.clear)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(UIColor.secondarySystemBackground))
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
    }
}

extension View {
    func listRowViewModifier() -> some View {
        modifier(ListRowViewModifier())
    }
}
