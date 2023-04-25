//
//  File.swift
//  
//
//  Created by Emma Gaubert on 25/04/2023.
//

import Foundation

struct PatchFriend: Codable {
    let id: UUID
    let userID: User?
    let usersFriendID: User?
}
