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
            List(viewModel.users, selection: $selectedUser) { user in
                NavigationLink(destination: DetailedUserProfile(user: Binding.constant(user))) {
                    Label(user.username, systemImage: "person.fill")
                }
                .swipeActions(edge: .trailing) {
                    Button {
                        Task {
                            try await viewModel.friendUser(user.id)
                        }
                    } label: {
                        Label("Friend user", systemImage: "person.fill.badge.plus")
                    }
                    .tint(.purple)
                }
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
