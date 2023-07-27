//
//  ChangeMyPassword.swift
//  Client
//
//  Created by Emma Gaubert on 05/07/2023.
//

import SwiftUI

struct ChangeMyPassword: View {
    @StateObject private var viewModel = UsersViewModel(networkManager: UserNetworkManager(httpClient: Networking()))
    var body: some View {
        Form {
            Section {
                SecureField("Current Password", text: $viewModel.currentPassword, prompt: Text("Current Password"))
                SecureField("Confirm Current Password", text: $viewModel.confirmCurrentPassword, prompt: Text("Confirm Current Password"))
            }
            Section {
                SecureField("New Password", text: $viewModel.newPassword, prompt: Text("New Password"))
                SecureField("Confirm New Password", text: $viewModel.confirmNewPasswordd, prompt: Text("Confirm New Password"))
            }
            Section {
                TextField("Favorite Book", text: $viewModel.favoriteBook, prompt: Text("Favorite Book"))
                TextField("FavoriteAuthor", text: $viewModel.favoriteAuthor, prompt: Text("Favorite Author"))
            }
            Button("Change my password") {
                print("changed password")
            }
        }
    }
}

struct ChangeMyPassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangeMyPassword()
    }
}
