//
//  Like.swift
//  
//
//  Created by Emma Gaubert on 14/03/2023.
//

import Fluent
import Vapor

/// Pivot table that stores likes
final class Like: Model, Content {
    static let schema = "likes"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Parent(key: "book_id")
    var book: Book
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() {}
    
    init(id: UUID? = nil,
         user: User,
         book: Book,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil)
    throws {
        self.id = id
        self.$user.id = try user.requireID()
        self.$book.id = try book.requireID()
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
