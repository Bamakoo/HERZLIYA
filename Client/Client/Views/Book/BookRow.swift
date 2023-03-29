//
//  BookRow.swift
//  Client
//
//  Created by Emma Gaubert on 21/02/2023.
//
// swiftlint:disable all

import SwiftUI

struct BookRow: View {
    var book: Book
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(book.title).font(.headline)
                Text(book.author).font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
            Text("\(book.price)$")
        }
    }
}

struct BookRow_Previews: PreviewProvider {
    static var books = BooksViewModel(networkManager: BooksNetworkManager(httpClient: HttpClient.self as! HttpClient)).books
    static var previews: some View {
        BookRow(book: books[0])
    }
}
