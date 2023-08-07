//
//  PatchPurchaseBook.swift
//  Client
//
//  Created by Emma Gaubert on 17/05/2023.
//

import Foundation

struct PatchPurchaseBook: Codable {
    let id: String
    let buyerID: String
    var status: String = "purchased"
}
