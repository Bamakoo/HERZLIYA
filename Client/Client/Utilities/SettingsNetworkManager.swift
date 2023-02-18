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
    
    func fetchBooks(){
        let url = URL(string: Request.baseURL + Endpoint.books)
    }
}
