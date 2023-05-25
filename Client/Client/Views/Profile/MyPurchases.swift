//
//  MyPurchases.swift
//  Client
//
//  Created by Emma Gaubert on 02/04/2023.
//

import SwiftUI

struct MyPurchases: View {
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var selection: GetBook?
    var body: some View {
        NavigationSplitView {
            List(viewModel.purchasedBooks, selection: $selection) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
            }
            .navigationTitle("Books I've Purchased")
            .listStyle(.grouped)
        } detail: {
            if let book = selection {
                BookDetail(book: $selection)
            } else {
                Text("Pick a book")
            }
        }
        .task {
                await viewModel.fetchPurchasedBooks()
        }
    }
}
struct MyPurchases_Previews: PreviewProvider {
    static var previews: some View {
        MyPurchases()
    }
}
