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
                    HStack {
                        Image(item.image)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .fontWeight(.thin)
                            .foregroundStyle(.primary)
                            .padding([.trailing], 8)
                        Text(item.title)
                            .font(.title3)
                            .foregroundStyle(.primary)
                            .fontWeight(.regular)
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Profile")
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
