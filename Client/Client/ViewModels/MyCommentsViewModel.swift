//
//  MyCommentsViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 04/07/2023.
//

import Foundation

@MainActor

final class MyCommentsViewModel: ObservableObject {
    @Published var myComments = [Comment]()
    func fetchMyComments(){
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/comments/users/70935759-4231-43E4-8E54-92CA3A48E33B")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer N6VQVmeHL2pogji/R6dypA==", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
               do {
                  let comments = try JSONDecoder().decode([Comment].self, from: data)
                   DispatchQueue.main.async {
                       self.myComments.append(contentsOf: comments)
                   }
               } catch let error {
                   print(error.localizedDescription)
               }
            }
        }
        task.resume()
    }
}
