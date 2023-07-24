//
//  ProfileViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 21/07/2023.
//

import Foundation
@MainActor
final class ProfileViewModel: ObservableObject {
    
    @TokenRepository<String>
    var token: String?

    @Published var likedBooks = [Book]()
    @Published var booksByUsersFavoriteAuthor = [Book]()

    
    func fetchLikedBooks() async throws {
        do {
            likedBooks = [Book]()
            likedBooks = try await UseCase.Books.fetchLikedBooks()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func bookByUsersFavoriteAuthor() async throws {
        booksByUsersFavoriteAuthor = [Book]()
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/books/favorite-author")!,timeoutInterval: Double.infinity)
        if let token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
               do {
                  let books = try JSONDecoder().decode([Book].self, from: data)
                   DispatchQueue.main.async {
                       self.booksByUsersFavoriteAuthor.append(contentsOf: books)
                   }
               } catch let error {
                   print(error.localizedDescription)
               }
            }
        }
        task.resume()
    }
}
