//
//  FeaturedRow.swift
//  Client
//
//  Created by Emma Gaubert on 29/08/2023.
//

import SwiftUI

enum ElementType: Codable {
    case comment(Comment)
    case rating(Rating)
    case book(Book)
    case user(GetUser)
    case like(Like)
}

struct Element: Identifiable, Codable {
    var id = UUID()
    let type: ElementType
}

struct FeaturedRow: View {

    var categoryName: String
    var elements: [Element]

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(elements) { element in
                        NavigationLink {
                            BookDetail(book: Binding.constant(Book(title: "hello",
                                                                   author: "dfvs",
                                                                   price: 12,
                                                                   state: .acceptable,
                                                                   descritpion: "ufuvidf",
                                                                   genre: .action,
                                                                   rating: 2)))
                        } label: {
                            FeaturedItem(element: Element(type: .book(Book(title: "hello",
                                                                           author: "author",
                                                                           price: 12,
                                                                           state: .acceptable,
                                                                           descritpion: "fvdfv",
                                                                           genre: .action, rating: 12))),
                                        homepageCategory: .books)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}
