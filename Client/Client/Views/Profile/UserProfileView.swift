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
            List(LinkNames.allCases) { linkName in
                NavigationLink(linkName.rawValue) {
                    ProfileDetail(linkName: linkName.rawValue)
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("My Profile")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: LinkNames.self) { linkName in
                switch linkName {
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
