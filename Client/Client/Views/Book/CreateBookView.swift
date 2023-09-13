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
        VStack {
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
            }
            Button {
                Task {
                    await viewModel.createBook()
                }
            } label: {
                Spacer()
                Text("Sell my book".uppercased())
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }
            .disabled(viewModel.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.purple))
                .padding([.bottom, .top], 5)
                .padding([.leading, .trailing], 30)
        }
    }
}

struct CreateBook_Previews: PreviewProvider {
    static var previews: some View {
        CreateBookView()
    }
}
