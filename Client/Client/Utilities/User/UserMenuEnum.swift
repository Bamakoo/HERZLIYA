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
        case .allComments: return "All comments"
        case .likesByMyFriends: return "Likes by my friends"
        case .booksByGenre:
            return "Books by genre"
        case .latestRatings:
            return "Latest ratings"
        case .users:
            return "Browse users"
        }
    }

    var image: String {
        switch self {
        case .likesByMyFriends: return "heart.fill"
        case .allComments:
            return "text.bubble"
        case .booksByGenre:
            return "books.vertical.fill"
        case .latestRatings:
            return "list.number"
        case .users:
            return "person.3.sequence.fill"
        }
    }
}
