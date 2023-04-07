//
//  UserProfileEnum.swift
//  Client
//
//  Created by Emma Gaubert on 30/03/2023.
//

import Foundation

struct NavigationItem: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var icon: String
    var menu: Menu
}

var navigationItems = [
    NavigationItem(title: "Friends", icon: "person.3.sequence.fill", menu: .friends),
    NavigationItem(title: "Books by my favorite author", icon: "bookmark.fill", menu: .booksByFavoriteAuthor),
    NavigationItem(title: "Likes", icon: "heart.circle.fill", menu: .likes),
    NavigationItem(title: "Cart", icon: "cart.fill", menu: .myKart),
    NavigationItem(title: "Purchases", icon: "basket.fill", menu: .purchases),
    NavigationItem(title: "Books I've sold", icon: "arrow.up.circle.fill", menu: .soldBooks)
]

enum Menu: String {
    case friends
    case booksByFavoriteAuthor
    case likes
    case myKart
    case purchases
    case soldBooks
}
