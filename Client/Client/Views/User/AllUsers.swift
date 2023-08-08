//
//  AllUsers.swift
//  Client
//
//  Created by Emma Gaubert on 07/08/2023.
//

import SwiftUI

struct AllUsers: View {

    @StateObject private var viewModel = UsersViewModel()
    @State private var selectedUser: FetchUser?

    var body: some View {
        NavigationSplitView {
            List(viewModel.users, selection: $selectedUser) { user in
                NavigationLink(value: user) {
                    Label(user.username, systemImage: "person.fill")
                }
            }
        } detail: {
            Text("hello world")
        }
        .onAppear {
            Task {
                try await viewModel.fetchUsers()
            }
        }
    }
}

struct AllUsers_Previews: PreviewProvider {
    static var previews: some View {
        AllUsers()
    }
}
