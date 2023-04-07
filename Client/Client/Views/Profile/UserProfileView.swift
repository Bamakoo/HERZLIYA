//
//  UserProfileView.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject private var viewModel = UsersViewModel(networkManager: UserNetworkManager(httpClient: Networking()))
    var body: some View {
        NavigationStack {
            List(navigationItems) { item in
                NavigationLink(value: item) {
                    Label(item.title, systemImage: item.icon)
                        .foregroundColor(.primary)
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("My Profile")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: NavigationItem.self) { item in
                switch item.menu {
                case .booksByFavoriteAuthor:
                    BooksByMyFavoriteAuthorView()
                case .friends:
                    MyFriendsView()
                case .likes:
                    LikesView()
                case .myKart:
                    KartView()
                case .purchases:
                    MyPurchases()
                case .soldBooks:
                    SoldBooks()
                }
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
