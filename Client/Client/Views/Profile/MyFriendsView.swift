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
                HStack(alignment: .center, spacing: 5) {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .fontWeight(.thin)
                        .foregroundStyle(.primary)
                        .padding([.trailing], 8)
                    Text(user.username)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .fontWeight(.medium)
                }
            }
            .swipeActions(edge: .trailing) {
                Button {
                    Task {
                        try await viewModel.deleteFriend(user.id)
                        try await viewModel.fetchMyFriends()
                    }
                } label: {
                    Label("Remove friend", systemImage: "person.fill.badge.minus")
                }
                .tint(.red)
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
