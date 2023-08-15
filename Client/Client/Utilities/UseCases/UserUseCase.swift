//
//  UserUseCase.swift
//  Client
//
//  Created by Emma Gaubert on 24/07/2023.
//

import Foundation

extension UseCase {
    struct User {

        static func deleteFriend(_ userID: UUID) async throws {
            try await API.User.deleteFriend(userID)
        }

        static func friendUser(_ userID: UUID) async throws {
            try await API.User.friendUser(userID)
        }

        static func fetchMyFriends() async throws -> [FetchUser] {
            let users = try await API.User.fetchMyFriends()
            return users
        }

        static func login(_ username: String, _ password: String) async throws {
            @TokenRepository<Any>
            var token: String?
            token = try await API.User.login(username, password)
        }

        static func fetchUsers() async throws -> [FetchUser] {
            try await API.User.fetch()
        }

        static func createNewUser(_ newUser: NewUser) async throws {
            try await API.User.create(newUser)
        }

        static func changePassword(_ patchedPassword: PatchPassword) async throws {
            try await API.User.changePassword(patchedPassword)
        }
    }
}
