//
//  PatchBook.swift
//  
//
//  Created by Emma Gaubert on 11/04/2023.
//

import Foundation

struct PatchBook: Codable {
    let id: UUID
    let title: String?
    let author: String?
    let description: String?
    let genre: BookGenre?
    let state: BookState?
    let price: Int?
    let buyerID: UUID?
    let kartID: UUID?
    let status: BookStatus?
}
