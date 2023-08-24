//
//  UserTests.swift
//  
//
//  Created by Emma Gaubert on 24/08/2023.
//

import Foundation
@testable import App
import XCTVapor

public final class UserTests: XCTestCase {
    func testUsersCanBeRetrievedFromAPI() throws {
        
        // Full CRUD
        // GET all users 200 is returned
        // POST/ CREATE a new user
        // POST Login
        // patch user
        // delete user
        
        let expectedUsername = "JackMalone"
        let expectedEmail = "jd@gmail.com"
        let expectedPasswordHash = "aRandomHash"
        let expectedFavoriteBook = "War and Peace"
        let expectedCountry = "Israel"
        let expectedCity = "Haifa"
        let expectedAuthor = "Tolstoi"
        
        
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        
        let user = User(username: expectedUsername,
                        email: expectedEmail,
                        passwordHash: expectedPasswordHash,
                        favoriteBook: expectedFavoriteBook,
                        country: expectedCountry,
                        city: expectedCity,
                        favoriteAuthor: expectedAuthor)
        try user.save(on: app.db).wait()
        
        
        try User(username: "Gail",
                 email: "g@gmail.com",
                 passwordHash: "password",
                 favoriteBook: "Crime and Punishment",
                 country: "France",
                 city: "Nantes",
                 favoriteAuthor: "Kundera")
        .save(on: app.db)
        .wait()
        
        let basic = "test:test".data(using: .utf8)!.base64EncodedString()
        
        try app.test(.GET, "/users", afterResponse: { response in
            XCTAssertEqual(response.status, .unauthorized)
        })
        try app.test(.POST, "/login", headers: ["Authorization": "Basic \(basic)"]) { response in
            let token = try response.content.decode(PostUserToken.self)
            Store.token = token.value
            XCTAssertEqual(response.status, .created)
            XCTAssertNotNil(token.value)
        }
        try app.test(.GET, "/users", headers: ["Authorization": "Bearer \(Store.token)"]) { response in
            let users = try response.content.decode([GetUser].self)
            XCTAssertEqual(response.status, .ok)
            XCTAssertEqual(users[users.count-2].username, expectedUsername)
            XCTAssertEqual(users[users.count-2].favoriteBook, expectedFavoriteBook)
            XCTAssertEqual(users[users.count-2].country, expectedCountry)
            XCTAssertEqual(users[users.count-2].city, expectedCity)
            XCTAssertEqual(users[users.count-2].favoriteAuthor, expectedAuthor)
            XCTAssertNotNil(users[users.count-2].id)
        }
    }
}

struct Store {
    static var token: String = ""
}
