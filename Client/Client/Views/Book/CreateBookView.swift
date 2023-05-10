//
//  CreateBookView.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import Foundation
import SwiftUI

struct CreateBookView: View {
    @StateObject var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    var body: some View {
        Form {
            Section {
                TextField("BookTitle", text: $viewModel.title, prompt: Text("Book's title"))
                    .background(Color.white)
                TextField("Author", text: $viewModel.author, prompt: Text("Author's Name"))
                    .background(Color.white)
                TextField("BookPrice",
                          value: $viewModel.price,
                          format: .currency(code: "USD"),
                          prompt: Text("Book's price"))
                .background(Color.white)
                .keyboardType(.decimalPad)
            }
        header: {
            Text("Author, Title & price")
                .foregroundColor(.black)
        } footer: {
            Text("Think long and hard about the price")
                .foregroundColor(.black)
        }
            Section {
                Picker("State", selection: $viewModel.state) {
                    ForEach(BookState.allCases) { state in
                        Text(state.rawValue)
                    }
                }
                Picker("Genre", selection: $viewModel.genre) {
                    ForEach(BookGenre.allCases) { genre in
                        Text(genre.rawValue)
                    }
                }
                TextField("Description", text: $viewModel.description, prompt: Text("Description"))
            }
        header: {
            Text("Books genre and state")
                .foregroundColor(.black)
            Button {
                Task {
                    // try await viewModel.createBook()
                }
            } label: {
                Text("Sell book")
            }
            .disabled(viewModel.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        }
    }
}
