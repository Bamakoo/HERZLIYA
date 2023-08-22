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
    @Environment(\.dismiss) var dismiss
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
            }
            Section {
                TextEditor(text: $viewModel.description)
            } header: {
                Text("Description")
            }
            Button {
                Task {
                    await viewModel.createBook()
                    dismiss()
                }
            } label: {
                Text("Sell book")
            }
            .disabled(viewModel.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }
}
