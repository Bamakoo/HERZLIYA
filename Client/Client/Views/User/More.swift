//
//  UserMenuView.swift
//  Client
//
//  Created by Emma Gaubert on 07/08/2023.
//

import SwiftUI

struct More: View {

    var body: some View {
        NavigationStack {
            List(UserMenu.allCases) { item in
                NavigationLink(value: item) {
                    Label(item.title, image: item.image)
                        .foregroundColor(.primary)
                }
            }
            .navigationDestination(for: UserMenu.self) { item in
                switch item {
                case .likesByMyFriends: AllLikes()
                case .allComments: AllComments()
                case .booksByGenre: BooksByGenre()
                case .latestRatings: AllRatings()
                case .users: AllUsers()
                }
            }
        }
    }
}

struct UserMenuView_Previews: PreviewProvider {
    static var previews: some View {
        More()
    }
}
