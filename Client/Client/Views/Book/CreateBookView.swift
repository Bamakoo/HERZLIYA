//
//  CreateBookView.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import Foundation
import SwiftUI

struct CreateBookView: View {
    @State private var title = ""
    @State private var genre = ""
    @State private var price = 0
    @State private var author = ""
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    var body: some View {
            TextField("BookTitle", text: $title, prompt: Text("Book's title"))
                .background(Color.white)
            TextField("BookGenre", text: $genre, prompt: Text("Book's genre"))
                .background(Color.white)
            TextField("BookPrice", value: $price, format: .currency(code: "USD"), prompt: Text("Book's price"))
                .background(Color.white)
                .keyboardType(.decimalPad)
            TextField("Author", text: $author, prompt: Text("Author's Name"))
                .background(Color.white)
            Button {
                Task {
                    try await viewModel.createBook(title: title, genre: genre, price: price, author: author, order: nil)
                }
            } label: {
                Text("Offer book for sale")
            }
        
    }
}
