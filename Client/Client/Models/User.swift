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
                               username: "DahliaG",
                               email: "dahlia-gostoli@gmail.com",
                               password_hash: "AReallyComplexHash",
                               password: "asMyGuitarGentlyWeeps",
                               confirmPassword: "asMyGuitarGentlyWeeps",
                              favoriteBook: "War and Peace by Leo Tolstoi",
                               country: "France",
                               city: "Nantes",
                               favoriteAuthor: "Boulgakov",
                               createdAt: nil,
                               updatedAt: nil,
                               deletedAt: nil)
    static let anotherTestUser = User(id: nil,
                                      username: "Emma",
                                      email: "emma.gaubert14@gmail.com",
                                      password_hash: "AReallyComplexHash",
                                      password: <#T##String?#>,
                                      confirmPassword: <#T##String?#>,
                                      favoriteBook: <#T##String?#>,
                                      country: <#T##String?#>,
                                      city: <#T##String?#>,
                                      favoriteAuthor: <#T##String?#>,
                                      createdAt: <#T##Date?#>,
                                      updatedAt: <#T##Date?#>,
                                      deletedAt: <#T##Date?#>)
}
