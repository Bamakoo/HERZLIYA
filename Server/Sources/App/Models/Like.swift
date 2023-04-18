//
//  Like.swift
//  
//
//  Created by Emma Gaubert on 14/03/2023.
//

import Fluent
import Vapor
// TODO: fix Like + relationships
/// Pivot table that stores likes
final class Like: Model, Content {
    static let schema = "likes"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Parent(key: "book_id")
    var book: Book
    
    init() {}
    
    init(id: UUID? = nil,
         user: User,
         book: Book) throws {
        self.id = id
        self.$user.id = try user.requireID()
        self.$book.id = try book.requireID()
    }
}
