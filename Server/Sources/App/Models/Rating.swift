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
    
    init() {}
    
    init(id: UUID? = nil,
         userWhoRates: User,
         ratedUser: User,
         rating: Float) throws {
        self.id = id
        self.$userWhoRates.id = try userWhoRates.requireID()
        self.$ratedUser.id = try ratedUser.requireID()
        self.rating = rating
    }
}
