import Foundation

struct FetchUser: Codable, Identifiable, Hashable {
    let username: String
    let id: UUID
    let favoriteBook: String
    let country: String
    let city: String
    let favoriteAuthor: String
}
