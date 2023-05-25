//
//  UserToken.swift
//  Client
//
//  Created by Emma Gaubert on 06/04/2023.
//

import Foundation

struct UserToken: Decodable {
    let value: String
    let userID: String
}
