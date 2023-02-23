//
//  BookRow.swift
//  Client
//
//  Created by Emma Gaubert on 21/02/2023.
//

import SwiftUI

struct BookRow: View {
    
    @State var book: Book
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(book.title ?? "the subtle art of not giving a fuck").font(.headline)
                Text(book.author ?? "Mark Manson").font(.subheadline).foregroundColor(.gray)
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
