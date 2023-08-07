//
//  UserMenuView.swift
//  Client
//
//  Created by Emma Gaubert on 07/08/2023.
//

import SwiftUI

struct UserMenuView: View {

    @State private var userMenu: [UserMenu] = UserMenu.allCases

    var body: some View {
        NavigationStack {
            List(userMenu) { item in
                NavigationLink(value: item) {
                    Label(item.title, systemImage: item.image)
                        .foregroundColor(.primary)
                }
            }
            .navigationDestination(for: UserMenu.self) { item in
                switch item {
                case .likesByMyFriends: LikesByMyFriends()
                case .allComments: AllComments()
                case .booksByGenre: BooksList()
                case .latestRatings: AllRatings()
                case .users: AllUsers()
                }
            }
        }
    }
}

struct UserMenuView_Previews: PreviewProvider {
    static var previews: some View {
        UserMenuView()
    }
}
