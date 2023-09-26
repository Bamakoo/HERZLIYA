//
//  SoldBooks.swift
//  Client
//
//  Created by Emma Gaubert on 02/04/2023.
//

import SwiftUI

struct SoldBooks: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var selection: Book?
    var body: some View {
            List(viewModel.soldBooks, selection: $selection) { book in
                NavigationLink(destination: BookDetail(book: Binding.constant(book))) {
                    BookRow(book: book)
                }
                .listRowViewModifier()
            }
            .navigationTitle("Books I've sold")
            .listViewModifier()
        .onAppear {
            Task {
                try await viewModel.soldBooks()
            }
        }
    }
}

struct SoldBooks_Previews: PreviewProvider {
    static var previews: some View {
        SoldBooks()
    }
}
