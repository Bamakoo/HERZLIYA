//
//  UserProfileEnum.swift
//  Client
//
//  Created by Emma Gaubert on 30/03/2023.
//

import Foundation

enum Menu: Identifiable, CaseIterable {
    case friends, booksByFavoriteAuthor, likes, myKart, purchases, soldBooks
    var id: Self { self }
    var title: String {
        switch self {
        case .friends: return "Friends"
        case .booksByFavoriteAuthor: return "Books by favorite author"
        case .likes: return "Likes"
        case .myKart: return "Cart"
        case .purchases: return "Purchased books"
        case .soldBooks: return "Sold books"
        }
    }
    var image: String {
        switch self {
        case .friends: return "tree.fill"
        case .booksByFavoriteAuthor: return "tree.fill"
        case .likes: return "tree.fill"
        case .myKart: return "tree.fill"
        case .purchases: return "tree.fill"
        case .soldBooks: return "tree.fill"
        }
    }
}
