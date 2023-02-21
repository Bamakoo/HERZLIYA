//
//  BookDetail.swift
//  Client
//
//  Created by Emma Gaubert on 21/02/2023.
//

import SwiftUI

struct BookDetail: View {
    
    var book: Book
    
    var body: some View {
        ScrollView {
            Text(book.author ?? "the subtle art of not giving a fuck")
            Text(book.title ?? "Mark Manson")
        }
        .navigationTitle(book.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BookDetail_Previews: PreviewProvider {
    static var previews: some View {
        BookDetail(book: BooksViewModel(networkManager: SettingNetworkManager(httpClient: HttpClient.self as! HttpClient)).books[0])
    }
}
