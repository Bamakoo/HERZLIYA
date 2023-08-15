//
//  MyFriendsView.swift
//  Client
//
//  Created by Emma Gaubert on 02/04/2023.
//

import SwiftUI

struct MyFriendsView: View {

    @StateObject private var viewModel = ProfileViewModel()
    @State private var selection: FetchUser?

    var body: some View {
        List(viewModel.myFriends, selection: $selection) { user in
            NavigationLink(destination: PublicProfileView(user: Binding.constant(user))) {
                Label(user.username, systemImage: "person.crop.circle.fill")
            }
        }
        .navigationTitle("My friends")
        .listStyle(.grouped)
        .onAppear {
            Task {
                try await viewModel.fetchMyFriends()
            }
        }
    }
}

struct MyFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        MyFriendsView()
    }
}
