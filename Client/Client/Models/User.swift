// swiftlint:disable all

import Foundation

 struct User: Identifiable, Codable, Hashable, Equatable {
    let id: UUID?
    let username: String?
    let email: String?
    let password_hash: String?
    let password: String?
    let confirmPassword: String?
    let favoriteBook: String?
    let country: String?
    let city: String?
    let favoriteAuthor: String?
    let createdAt: Date?
    let updatedAt: Date?
    let deletedAt: Date?
 }

extension User {
    static var isLoggedIn: Bool = false 
}
