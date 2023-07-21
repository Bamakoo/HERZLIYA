//
//  ProfileViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 21/07/2023.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    @TokenRepository<String>
    var token: String?
    @Published var likedBooks = [Book]()
    
    func fetchLikedBooks() async throws {
        likedBooks = [Book]()
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/books/likes")!,timeoutInterval: Double.infinity)
        if let token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
               do {
                  let books = try JSONDecoder().decode([Book].self, from: data)
                   DispatchQueue.main.async {
                       self.likedBooks.append(contentsOf: books)
                   }
               } catch let error {
                   print(error.localizedDescription)
               }
            }
        }
        task.resume()
    }
}
