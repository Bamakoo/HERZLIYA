//
//  UserProfileEnum.swift
//  Client
//
//  Created by Emma Gaubert on 30/03/2023.
//

import Foundation

enum LinkNames: String, CaseIterable, Identifiable {
    case friends = "Friends"
    case booksByFavoriteAuthor = "Available books by your favorite author"
    case likes = "Likes"
    case myKart = "Your Kart"
    case purchases = "Purchases"
    case soldBooks = "Sold books"
    var id: Self {
        return self
    }
}
