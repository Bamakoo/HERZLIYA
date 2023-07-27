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
    func changePassword(with DTO: PatchPassword) async throws {
        guard let url = URL(string: "http://127.0.0.1:8080/change-password") else {
            return
        }
        _ = try await httpClient.sendData(to: url, object: DTO, httpMethod: HttpMethods.PATCH.rawValue)
    }

    func deleteProfile(id: UUID) async throws {
        let url = URL(string: Request.baseURL + Endpoint.users + "/\(id)")!
        try await httpClient.delete(url: url)
    }
}
