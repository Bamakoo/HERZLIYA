//
//  UserNetworkManager.swift
//  Client
//
//  Created by Emma Gaubert on 24/03/2023.
//

import Foundation

final class UserNetworkManager {
    let httpClient: HttpClient
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func getMe() async throws -> User {
        let url = URL(string: Request.baseURL + Endpoint.me!)
    }
}
