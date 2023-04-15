//
//  Like.swift
//  
//
//  Created by Emma Gaubert on 14/03/2023.
//

import Fluent
import Vapor
// TODO: fix Like + relationships
final class Like: Model, Content {
    static let schema = "likes"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user")
    var user: User
    
    @Parent(key: "liked_book")
    var likedBook: Book
    
    init() {}
    
    init(id: UUID? = nil,
         userID: User.IDValue,
         likedBookID: Book.IDValue) {
        self.id = id
        self.$user.id = userID
        self.$likedBook.id = likedBookID
    }
}
