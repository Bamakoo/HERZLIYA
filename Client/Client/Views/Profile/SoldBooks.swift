//
//  SoldBooks.swift
//  Client
//
//  Created by Emma Gaubert on 02/04/2023.
//

import SwiftUI

struct SoldBooks: View {
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var selection: GetBook?
    var body: some View {
        NavigationSplitView {
            List(viewModel.soldBooks, selection: $selection) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
            }
            .navigationTitle("Books I've Purchased")
            .listStyle(.grouped)
        } detail: {
            if selection != nil {
                BookDetail(book: $selection)
            } else {
                Text("Pick a book")
            }
        }
        .task {
                await viewModel.soldBooks()
        }
    }
}

struct SoldBooks_Previews: PreviewProvider {
    static var previews: some View {
        SoldBooks()
    }
}
