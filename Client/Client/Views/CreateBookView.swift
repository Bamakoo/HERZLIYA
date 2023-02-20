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
    @State private var price = ""
    @State private var authorFirstName = ""
    @State private var authorLastName = ""
    
    @StateObject private var viewModel = CreateBookViewModel(networkManager: SettingNetworkManager(httpClient: Networking()))
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("BookTitle", text: $title, prompt: Text("Your book's title"))
                .textFieldStyle(.roundedBorder)
            TextField("BookGenre", text: $genre, prompt: Text("Book's genre"))
                .textFieldStyle(.roundedBorder)
            TextField("BookPrice", text: $price, prompt: Text("Book's price"))
                .textFieldStyle(.roundedBorder)
            TextField("AuthorFirstName", text: $authorFirstName, prompt: Text("Author's First Name"))
                .textFieldStyle(.roundedBorder)
            TextField("AuthorLastName", text: $authorLastName, prompt: Text("Author's Last Name"))
                .textFieldStyle(.roundedBorder)
            Button {
                Task {
                    try await viewModel.createBooks()
                }
            } label: {
                Text("Offer book for sale")
            }
        }
    }
}
