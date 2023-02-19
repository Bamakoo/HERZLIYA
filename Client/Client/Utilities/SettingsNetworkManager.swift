//
//  SettingsNetworkManager.swift
//  Client
//
//  Created by Emma Gaubert on 17/02/2023.
//

import Foundation

final class SettingNetworkManager {
    
    let httpClient: HttpClient
    
    init(httpClient: HttpClient){
        self.httpClient = httpClient
    }
    
    func fetchBooks() async throws -> [Book] {
        let url = URL(string: Request.baseURL + Endpoint.books)!
        let books: [Book] = try await httpClient.fetch(url: url)
        return books
    }
    
    func fetchAuthors() async throws -> [Author] {
        let url = URL(string: Request.baseURL + Endpoint.authors)!
        let authors: [Author] = try await httpClient.fetch(url: url)
        return authors
    }
    
    func createAuthor(firstName: String, lastName: String) async throws {
        let url = URL(string: Request.baseURL + Endpoint.authors)!
        let newAuthor = Author(id: nil, firstName: firstName, lastName: lastName)
        try await httpClient.sendData(to: url, object: newAuthor, httpMethod: HttpMethods.POST.rawValue)
    }
}
