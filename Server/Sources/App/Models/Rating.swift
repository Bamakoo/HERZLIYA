//
//  Ratings.swift
//
//
//  Created by Emma Gaubert on 14/03/2023.
//

import Fluent
import Vapor

final class Rating: Model, Content {
    static let schema = "ratings"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Parent(key: "book_id")
    var book: Book
    
    @Field(key: "rating")
    var rating: Float
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() {}
    
    init(id: UUID? = nil,
         userID: User.IDValue,
         bookID: Book.IDValue,
         rating: Float,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil) throws {
        self.id = id
        self.$user.id = userID
        self.$book.id = bookID
        self.rating = rating
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
