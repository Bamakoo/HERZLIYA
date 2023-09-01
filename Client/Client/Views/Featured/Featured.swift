//
//  Featured.swift
//  Client
//
//  Created by Emma Gaubert on 28/08/2023.
//
import Foundation
import SwiftUI

enum HomepageCategory: String, Identifiable, CaseIterable {
    var id: Self { self }
    case books = "Books"
    case users = "Users"
    case comments = "Comments"
    case ratings = "Ratings"
    case likes = "Likes"

    var image: String {
        switch self {
        case .books: return "book"
        case .comments: return "text.bubble"
        case .ratings: return "star"
        case .users: return "person.3"
        case .likes: return "heart"
        }
    }
}

struct Featured: View {

    @StateObject private var viewModel = HomepageViewModel()
    @State private var devElements: [Element] = [Element(type: .book(.init(title: "hello",
                                                                           author: "hello",
                                                                           price: 12,
                                                                           state: .acceptable,
                                                                           descritpion: "vsdkfnvsd",
                                                                           genre: .action,
                                                                           rating: 34))),
                                                 Element(type: .comment(.init(id: UUID(),
                                                                              userID: "1234",
                                                                              bookID: UUID(),
                                                                              comment: "vnfvnv",
                                                                              username: "anotherrandomuser", bookTitle: "dfbvuidbvsdf")))]

    var body: some View {
        NavigationView {
            List {
                Image(systemName: "book")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                ForEach(HomepageCategory.allCases) { category in
                    FeaturedRow(categoryName: category.rawValue, elements: devElements)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Featured")
        }
    }
}

struct Featured_Previews: PreviewProvider {
    static var previews: some View {
        Featured()
    }
}
