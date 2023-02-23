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
    @State private var cost = ""
    @State private var author = ""

    var price: Int {
           guard let price = Int(cost) else {
               return 0
           }
        return price
       }
    
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    
    var body: some View {
        Form {
            TextField("BookTitle", text: $title, prompt: Text("Book's title"))
                .textFieldStyle(.roundedBorder)
            TextField("BookGenre", text: $genre, prompt: Text("Book's genre"))
                .textFieldStyle(.roundedBorder)
            TextField("BookPrice", text: $cost, prompt: Text("Book's price"))
                .textFieldStyle(.roundedBorder)
            TextField("Author", text: $author, prompt: Text("Author's Name"))
                .textFieldStyle(.roundedBorder)
            Button {
                Task {
                    try await viewModel.createBooks(title: title, genre: genre, price: price, author: author)
                }
            } label: {
                Text("Offer book for sale")
            }
        }
    }
}
