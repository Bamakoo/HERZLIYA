//
//  UserMenuEnum.swift
//  Client
//
//  Created by Emma Gaubert on 07/08/2023.
//

import Foundation

enum UserMenu: Identifiable, CaseIterable {

    case allComments, likesByMyFriends, booksByGenre, latestRatings, users

    var id: Self { self }

    var title: String {
        switch self {
        case .allComments: return "Comments"
        case .likesByMyFriends: return "Likes"
        case .booksByGenre:
            return "Books by genre"
        case .latestRatings:
            return "Ratings"
        case .users:
            return "Users"
        }
    }

    var image: String {
        switch self {
        case .likesByMyFriends: return "heart"
        case .allComments:
            return "text.bubble"
        case .booksByGenre:
            return "books.vertical"
        case .latestRatings:
            return "star"
        case .users:
            return "person.3"
        }
    }
}
