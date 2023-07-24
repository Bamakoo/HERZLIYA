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
    @Published var kartBooks = [Book]()
    @Published var soldBooks = [Book]()

    func fetchLikedBooks() async throws {
        do {
            likedBooks = try await UseCase.Books.fetchLikedBooks()
        } catch {
            print(error.localizedDescription)
        }
    }
   
    func bookByUsersFavoriteAuthor() async throws {
        do {
            booksByUsersFavoriteAuthor = try await UseCase.Books.fetchBookByUsersFavoriteAuthor()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getBooksInKart() async throws {
        do {
            kartBooks = try await UseCase.Books.fetchBooksInKart()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func soldBooks() async throws {
        soldBooks = [Book]()
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/books/sold")!,timeoutInterval: Double.infinity)
        if let token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let books = try JSONDecoder().decode([Book].self, from: data)
                    DispatchQueue.main.async {
                        self.soldBooks.append(contentsOf: books)
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
