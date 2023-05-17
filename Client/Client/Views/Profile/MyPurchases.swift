//
//  MyPurchases.swift
//  Client
//
//  Created by Emma Gaubert on 02/04/2023.
//

import SwiftUI

struct MyPurchases: View {
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var selectedBook: GetBook?
    var body: some View {
        List(viewModel.purchasedBooks, selection: $selectedBook) { book in
            NavigationLink(value: book) {
                BookRow(book: book)
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
