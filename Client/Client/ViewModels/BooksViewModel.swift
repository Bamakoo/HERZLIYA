//
//  BooksViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation
// TODO: PUT and DELETE operations
final class BooksViewModel: ObservableObject {
    @Published var title = ""
    @Published var author = ""
    @Published var description = ""
    @Published var genre: BookGenre = .action
    @Published var state: BookState = .acceptable
    @Published var price = 0
    @Published var seller: User = User.testUser
    @Published var status: BookStatus = .purchased
    @Published var books = [Book]()
    private let networkManager: BooksNetworkManager
    init(networkManager: BooksNetworkManager) {
        self.networkManager = networkManager
    }
    @MainActor
    func fetchBooks() async {
        do {
            books = try await networkManager.fetchBooks()
        } catch {
            print("unable to fetch books because of : \(error.localizedDescription)")
        }
    }
    func deleteBook(id: UUID) async throws {
        do {
            try await networkManager.deleteBook(id: id)
        } catch {
            print(error.localizedDescription)
        }
    }
    func createBook() async throws {
        guard !title.isEmpty && !author.isEmpty else {
            print("Empty title and author")
            return
        }
        guard let url = URL(string: Request.baseURL + Endpoint.books) else {
            print("unable to create an URL to perform POST operation on Books table")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.POST.rawValue
        // TODO: fix token so it's not hard coded
        let token = "wbj4h8R4YPh0AATndgk4eg=="
        request.setValue(("Bearer \(token)"), forHTTPHeaderField: HttpHeaders.authorization.rawValue)
        let data = Book(id: nil,
                        author: author,
                        description: description,
                        genre: genre,
                        state: state,
                        seller: User.testUser,
                        buyer: nil,
                        kart: Kart(id: nil, user: nil, total: nil),
                        status: status,
                        title: title,
                        price: price,
                        createdAt: nil,
                        updatedAt: nil,
                        deletedAt: nil)
        guard let jsonData = try? JSONEncoder().encode(data) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        request.setValue("application/json", forHTTPHeaderField: HttpHeaders.contentType.rawValue)
        request.setValue("application/json", forHTTPHeaderField: HttpHeaders.accept.rawValue)
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
//    func updateBook() {
//        guard let url = URL(string: Request.baseURL + Endpoint.books) else {
//            print("unable to create an URL to perform POST operation on Books table")
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = HttpMethods.PUT.rawValue
//        let updatedBook = Book(id: UUID(),
//                               author: ,
//                               description: <#T##String#>,
//                               genre: <#T##BookGenre#>,
//                               state: <#T##BookState#>,
//                               seller: <#T##User#>,
//                               buyer: <#T##User?#>,
//                               kart: <#T##Kart?#>,
//                               status: <#T##BookStatus#>,
//                               title: <#T##String#>,
//                               price: <#T##Int#>,
//                               createdAt: <#T##Date?#>,
//                               updatedAt: <#T##Date?#>,
//                               deletedAt: <#T##Date?#>)
//        guard let jsonData = try? JSONEncoder().encode(updatedBook) else {
//            print("Error: Trying to convert model to JSON data")
//            return
//        }
//        request.setValue("application/json", forHTTPHeaderField: HttpHeaders.contentType.rawValue)
//        request.setValue("application/json", forHTTPHeaderField: HttpHeaders.accept.rawValue)
//        request.httpBody = jsonData
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard error == nil else {
//                print("Error: error calling PUT")
//                print(error!)
//                return
//            }
//            guard let data = data else {
//                print("Error: Did not receive data")
//                return
//            }
//            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
//                print("Error: HTTP request failed")
//                return
//            }
//            do {
//                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                    print("Error: Cannot convert data to JSON object")
//                    return
//                }
//                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
//                    print("Error: Cannot convert JSON object to Pretty JSON data")
//                    return
//                }
//                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//                    print("Error: Could print JSON in String")
//                    return
//                }
//
//                print(prettyPrintedJson)
//            } catch {
//                print("Error: Trying to convert JSON data to string")
//                return
//            }
//        }.resume()
//    }
}
