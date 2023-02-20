//
//  CreateAuthorsView.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation
import SwiftUI

struct CreateAuthorView: View {
    
    @State private var authorFirstName = ""
    @State private var authorLastName = ""
    
    @StateObject private var viewModel = CreateAuthorViewModel(networkManager: SettingNetworkManager(httpClient: Networking()))
    var body: some View {
        VStack(alignment: .leading) {
            TextField("AuthorFirstName", text: $authorFirstName, prompt: Text("Author's First Name"))
                .textFieldStyle(.roundedBorder)
            TextField("AuthorLastName", text: $authorLastName, prompt: Text("Author's Last Name"))
                .textFieldStyle(.roundedBorder)
            Button {
                Task {
                    try await viewModel.createAuthors(firstName: authorFirstName, lastName: authorLastName)
                }
            } label: {
                Text("Create new author")

            }
        }
    }
}
