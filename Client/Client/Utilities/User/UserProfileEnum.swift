//
//  UserProfileEnum.swift
//  Client
//
//  Created by Emma Gaubert on 30/03/2023.
//

import Foundation

enum ProfileMenu: Identifiable, CaseIterable {
    case friends, booksByFavoriteAuthor, likes, myKart, purchases, soldBooks, commentsOnMyBooks, myComments
    var id: Self { self }
    var title: String {
        switch self {
        case .friends: return "Friends"
        case .booksByFavoriteAuthor: return "Books by favorite author"
        case .likes: return "Likes"
        case .myKart: return "Cart"
        case .purchases: return "Purchased books"
        case .soldBooks: return "Sold books"
        case .commentsOnMyBooks: return "Comments on my books"
        case .myComments: return "My comments"
        }
    }
    var image: String {
        switch self {
        case .friends: return "person.3"
        case .booksByFavoriteAuthor:
            return "hand.thumbsup.fill"
        case .likes: return "heart.fill"
        case .myKart: return "cart.fill"
        case .purchases: return "purchased.circle.fill"
        case .soldBooks: return "book.closed"
        case .commentsOnMyBooks: return "speaker.fill"
        case .myComments: return "person.3.fill"
        }
    }
}
