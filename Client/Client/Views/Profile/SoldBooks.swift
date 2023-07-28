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
        NavigationSplitView {
            List(viewModel.soldBooks, selection: $selection) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
            }
            .navigationTitle("Books I've sold")
            .listStyle(.grouped)
        } detail: {
            if selection != nil {
                BookDetail(book: $selection)
            } else {
                Text("Pick a book")
            }
        }
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
