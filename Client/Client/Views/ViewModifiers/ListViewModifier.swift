//
//  ListViewModifier.swift
//  Client
//
//  Created by Emma Gaubert on 25/09/2023.
//

import SwiftUI

struct ListViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listStyle(.inset)
            .scrollContentBackground(.hidden)
    }
}

extension View {
    func listViewModifier() -> some View {
        modifier(ListViewModifier())
    }
}
