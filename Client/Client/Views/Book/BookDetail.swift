//
//  BookDetail.swift
//  Client
//
//  Created by Emma Gaubert on 21/02/2023.
//
// swiftlint:disable all

import SwiftUI

struct BookDetail: View {
    var book: GetBook
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    var body: some View {
        TextField("BookTitle", text: $viewModel.title, prompt: Text(book.title).bold())
        TextField("BookPrice", value: $viewModel.price, format: .currency(code: "USD"), prompt: Text(String(book.price)))
            .background(Color.white)
            .keyboardType(.numberPad)
        TextField("Author", text: $viewModel.author, prompt: Text(book.author).bold())
            .background(Color.white)
        Button {
            Task {
                print("update book with new seller ID")
            }
        } label: {
            Text("Purchase book \(book.title)")
        }
        Button {
            Task {
                print("added \(book.title) to kart")
            }
        } label: {
            Text("Add to kart")
        }
        .navigationBarTitle(book.title, displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        try await viewModel.deleteBook(id: book.id!)
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
