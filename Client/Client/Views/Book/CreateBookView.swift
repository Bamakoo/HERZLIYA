//
//  CreateBookView.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import Foundation
import SwiftUI

struct CreateBookView: View {
    
    @ObservedObject var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    var body: some View {
        Form {
            TextField("BookTitle", text: $viewModel.title, prompt: Text("Book's title"))
                .background(Color.white)
            Picker("Genre", selection: $viewModel.genre) {
                ForEach(BookGenre.allCases) { genre in
                    Text(genre.rawValue.capitalized)
                }
            }
            Picker("State", selection: $viewModel.state) {
                ForEach(BookState.allCases) { state in
                    Text(state.rawValue.capitalized)
                }
            }
            TextField("BookPrice", value: $viewModel.price, format: .currency(code: "USD"), prompt: Text("Book's price"))
                .background(Color.white)
                .keyboardType(.decimalPad)
            TextField("Author", text: $viewModel.author, prompt: Text("Author's Name"))
                .background(Color.white)
            TextField("Description", text: $viewModel.description, prompt: Text("Description"))
        }
        Button {
            Task {
                try await viewModel.createBook()
            }
        } label: {
            Text("Offer book for sale")
        }
    }
}
