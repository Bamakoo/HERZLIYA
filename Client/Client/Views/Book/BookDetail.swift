//
//  BookDetail.swift
//  Client
//
//  Created by Emma Gaubert on 21/02/2023.
//
// swiftlint:disable all

import SwiftUI

struct BookDetail: View {
    @Binding var book: GetBook?
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    var body: some View {
        Form {
            Text(book!.title)
            Text(String(book!.price))
                .background(Color.white)
            Text(book!.author).bold()
                .background(Color.white)
            Button {
                Task {
                    await viewModel.purchaseBook(bookID: (book?.id)!)
                }
            } label: {
                
                Text("Purchase \(book!.title)")
            }
            Button {
                Task {
                    await viewModel.addBookToKart((book?.id)!)
                }
            } label: {
                Text("Add to kart")
            }
            .navigationBarTitle(book!.title, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            try await viewModel.deleteBook(id: book!.id!)
                        }
                    } label: {
                        Image(systemName: "trash.circle")
                    }
                }
            }
        }
        .onDisappear {
            // Task { await viewModel.fetchBooksByCategory(genre!) }
            print("book detail vanishes")
        }
    }
}
