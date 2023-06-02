//
//  CreateKartBookData.swift
//  Server
//
//  Created by Emma Gaubert on 26/05/2023.
//
import Vapor
import Vapor
import Foundation

struct CreateKartBookData: Content {
    let kartID: UUID
    let bookID: UUID
}
