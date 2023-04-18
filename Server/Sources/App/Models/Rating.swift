//
//  Ratings.swift
//
//
//  Created by Emma Gaubert on 14/03/2023.
//

import Fluent
import Vapor
final class UserUser: Model, Content {
    static let schema = "user"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Parent(key: "user_id")
    var user: User
    
    @Field(key: "rating")
    var rating: Float
    
    init() {}
    
    init(id: UUID? = nil,
         userWhoRatesID: User.IDValue,
         ratedUserID: User.IDValue,
         rating: Float) {
        self.id = id
        self.$userWhoRates.id = userWhoRatesID
        self.$ratedUser.id = ratedUserID
        self.rating = rating
    }
}
