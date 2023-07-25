//
//  UserUseCase.swift
//  Client
//
//  Created by Emma Gaubert on 24/07/2023.
//

import Foundation

extension UseCase {
    struct User {
        static func login(_ username: String, _ password: String) async throws {
            try await API.User.login(username, password)
        }
    }
}
