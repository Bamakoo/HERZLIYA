//
//  UserProfileView.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject private var viewModel = UsersViewModel()
    @State private var updateProfile = false
    var body: some View {
        NavigationStack {
            List(ProfileMenu.allCases) { item in
                NavigationLink(value: item) {
                    Label(item.title, systemImage: item.image)
                        .foregroundColor(.primary)
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("My Profile")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        updateProfile.toggle()
                    }, label: {
                        Image(systemName: "gear")
                    })
                    .sheet(isPresented: $updateProfile) {
                        UpdateProfile()
                    }
                    .navigationDestination(for: ProfileMenu.self) { item in
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
                        case .commentsOnMyBooks:
                            CommentsOnMyBooksView()
                        case .myComments:
                            MyComments()
                        }
                    }
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
