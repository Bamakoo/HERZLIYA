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
        VStack {
            Text(book.title ?? "the subtle art of not giving a fuck")
                .fontWeight(.heavy)

            Text(book.author ?? "Mark Manson")
                .italic()

        }
    }
}

struct BookRow_Previews: PreviewProvider {
    static var books = BooksViewModel(networkManager: SettingNetworkManager(httpClient: HttpClient.self as! HttpClient)).books
    static var previews: some View {
        BookRow(book: books[0])
    }
}
