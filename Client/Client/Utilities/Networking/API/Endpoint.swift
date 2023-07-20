//
//  Endpoint.swift
//  Client
//
//  Created by Emma Gaubert on 05/07/2023.
//

import Foundation

protocol APIEndpoint {
    var url: URL? { get }
}

struct HerzliyaEndpoint: APIEndpoint {
    let path: String
    let queryItems: [URLQueryItem]?
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "127.0.0.1"
        urlComponents.port = 8080
        urlComponents.path = path
        if let queryItems {
            urlComponents.queryItems = queryItems
        }
        print(urlComponents.url)
        return urlComponents.url
    }
}

struct NewEndpoint {
    static func book() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books", queryItems: nil)
    }
}
