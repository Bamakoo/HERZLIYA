//
//  Ratings.swift
//
//
//  Created by Emma Gaubert on 14/03/2023.
//

import Fluent
import Vapor
final class Rating: Model, Content {
    static let schema = "rating"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_who_rates")
    var userWhoRates: User
    
    @Parent(key: "rated_user")
    var ratedUser: User
    
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
         userWhoRatesID: User.IDValue,
         ratedUserID: User.IDValue,
         rating: Float,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil) throws {
        self.id = id
        self.$userWhoRates.id = userWhoRatesID
        self.$ratedUser.id = ratedUserID
        self.rating = rating
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
