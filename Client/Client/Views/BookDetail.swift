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
        VStack {
            Text(book.author ?? "the subtle art of not giving a fuck")
                .font(.title)
            Text(book.genre ?? "timeless classic")
            Text(String(book.price))
        }
        .padding()
        .navigationBarTitle(book.title ?? "les misérables", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("edit button tapped for book \(book.title ?? "the subtle art")")
                } label: {
                    Text("Edit")
                }
            }
        }
    }
}


struct BookDetail_Previews: PreviewProvider {
    static var previews: some View {
        BookDetail(book: BooksViewModel(networkManager: BooksNetworkManager(httpClient: HttpClient.self as! HttpClient)).books[0])
    }
}
