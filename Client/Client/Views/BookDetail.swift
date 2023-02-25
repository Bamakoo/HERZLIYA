//
//  BookDetail.swift
//  Client
//
//  Created by Emma Gaubert on 21/02/2023.
//

import SwiftUI

struct BookDetail: View {
    var book: Book
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var title = ""
    @State private var genre = ""
    @State private var price = 0
    @State private var author = ""
    
    var body: some View {
        Form {
            TextField("BookTitle", text: $title, prompt: Text(book.title).bold())
            TextField("BookGenre", text: $genre, prompt: Text(book.genre).bold())
            TextField("BookPrice", value: $price, format: .currency(code: "USD"), prompt: Text(String(book.price)))
                .background(Color.white)
                .keyboardType(.numberPad)
            TextField("Author", text: $author, prompt: Text(book.author).bold())
                .background(Color.white)
            Button {
                Task {
                    print("update button pressed")
                    try await viewModel.updateBook(author: author, id: book.id, title: title, price: price, genre: genre)
                }
            } label: {
                Text("Update book")
            }
            Button {
                Task {
                    try await viewModel.deleteBook(id: book.id)
                }
            } label: {
                Text("Delete book")
            }
        }
        .navigationBarTitle(book.title, displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        try await viewModel.deleteBook(id: book.id)
                    }
                } label: {
                    Image(systemName: "trash.circle")
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
