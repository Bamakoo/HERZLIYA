//
//  UserProfileView.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject private var viewModel = UsersViewModel(networkManager: UserNetworkManager(httpClient: Networking()))
    @State private var menu: [Menu] = Menu.allCases
    var body: some View {
        NavigationStack {
            List(menu) { item in
                NavigationLink(value: item) {
                    Label(item.title, systemImage: item.image)
                        .foregroundColor(.primary)
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("My Profile")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Menu.self) { item in
                switch item {
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
