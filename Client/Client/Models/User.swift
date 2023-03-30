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
   static let testUser = User(id: nil,
                               username: "",
                               email: "kireyin@datadome.co",
                               password_hash: "AReallyComplexHash",
                               password: "iPhonesRDaBest",
                               confirmPassword: "iPhonesRDaBest",
                              favoriteBook: "Brave new world by Huxley",
                               country: "Taiwan",
                               city: "Taipei",
                               favoriteAuthor: "Boulgakov",
                               createdAt: nil,
                               updatedAt: nil,
                               deletedAt: nil)
}
