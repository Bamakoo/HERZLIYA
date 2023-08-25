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
        let expectedEmail = "lqdfjkbvqjfbvqfdvbdfxdsvsvsvjdvihvor@gmail.com"
        let expectedPasswordHash = "aRandomHash"
        let expectedFavoriteBook = "War and Peace"
        let expectedCountry = "Israel"
        let expectedCity = "Haifa"
        let expectedAuthor = "Tolstoi"
        
        
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        
        let createdUser = User.Create(username: "expectedUsername",
                                      email: "lmlvsdjkvsbdfvoidjvfdoorn@gmail.com",
                                      password: "complexPWD",
                                      confirmPassword: "complexPWD",
                                      favoriteBook: "War and Peace",
                                      country: "Germany",
                                      city: "Hamburg",
                                      favoriteAuthor: "Shakespeare")
        
        let user = User(username: expectedUsername,
                        email: expectedEmail,
                        passwordHash: expectedPasswordHash,
                        favoriteBook: expectedFavoriteBook,
                        country: expectedCountry,
                        city: expectedCity,
                        favoriteAuthor: expectedAuthor)
        try user.save(on: app.db).wait()
        
        
        try User(username: "Gail",
                 email: "gaiwdfvdfvxdjvxjdvdjvsbvsjdvbskdfvhvfodivhi@gmail.com",
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
        
        try app.test(.POST, "/users", beforeRequest: { req in
            try req.content.encode(createdUser)
        }, afterResponse: { response in
            let receivedUser = try response.content.decode(GetUser.self)
            XCTAssertNotNil(receivedUser.id)
            XCTAssertEqual(response.status, .created)
            XCTAssertEqual(receivedUser.username, "expectedUsername")
            XCTAssertEqual(receivedUser.favoriteBook, "War and Peace")
            XCTAssertEqual(receivedUser.country, "Germany")
            XCTAssertEqual(receivedUser.city, "Hamburg")
            XCTAssertEqual(receivedUser.favoriteAuthor, "Shakespeare")
        })
    }
}

struct Store {
    static var token: String = ""
    static var bookID = UUID()
}
