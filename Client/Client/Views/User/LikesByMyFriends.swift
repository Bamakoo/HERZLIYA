//
//  LikesByMyFriends.swift
//  Client
//
//  Created by Emma Gaubert on 07/08/2023.
//

import SwiftUI

struct LikesByMyFriends: View {

    @StateObject private var viewModel = LikesViewModel()
    @State private var selectedLike: Like?

    var body: some View {
        List(viewModel.allLikes, selection: $selectedLike) { like in
            NavigationLink(destination: DetailedLikeView(like: Binding.constant(like))) {
                if let likeUsername = like.username {
                    Label(likeUsername, systemImage: "person.fill")
                }
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchAllLikes()
            }
        }
    }
}
