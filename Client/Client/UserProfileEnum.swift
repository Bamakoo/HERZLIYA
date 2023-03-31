//
//  UserProfileEnum.swift
//  Client
//
//  Created by Emma Gaubert on 30/03/2023.
//

import Foundation

enum LinkNames: String, CaseIterable, Identifiable {
    case friends = "Friends"
    case booksByFavoriteAuthor = "Favorite author's books"
    case likes = "Likes"
    case myKart = "Kart"
    case purchases = "Purchases"
    case soldBooks = "Sold books"
    var id: Self {
        return self
    }
}
