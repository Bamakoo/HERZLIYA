//
//  File.swift
//  
//
//  Created by Emma Gaubert on 12/05/2023.
//

import Foundation
import Vapor
import Fluent

struct PostUserToken: Content {
    var userID: UUID
    var value: String
}
