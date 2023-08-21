//
//  BookDetail.swift
//  Client
//
//  Created by Emma Gaubert on 21/02/2023.
//

import SwiftUI

struct BookDetail: View {

    @Binding var book: Book?
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var fullText: String = "Your comment"

    var body: some View {
        Form {
            if let book {
                HStack {
                    Image(systemName: "book")
                    Text("Title: \(book.title)")
                }
                HStack {
                    Image(systemName: "dollarsign")
                    Text("Price: \(book.price)")
                }
                HStack {
                    Image(systemName: "person")
                    Text("Author: \(book.author)")
                }
                HStack {
                    Image(systemName: book.state.image)
                    Text("State: \(book.state.rawValue)")
                }
            }
            Section {
                Stepper("Rating", value: $viewModel.rating, in: 0 ... 10, step: 0.1)

                Button {
                    Task {
                        if let book {
                            try await viewModel.rateBook(book)
                        }
                    }
                } label: {
                    if let book {
                        Label("Give \(book.title) a \(String(format: "%g", viewModel.rating)) rating", systemImage: "number.circle.fill")
                    }
                }
            }
            Section {
                TextEditor(text: $fullText)
                    .foregroundColor(Color.gray)
                    .lineSpacing(5)
                if let book {
                    Button("Comment on \(book.title)") {
                        Task {
                                try await viewModel.commentOnBook(book, fullText)
                                try await viewModel.fetchBookComments(book)
                        }
                    }
                }
            }
            Section {
                List(viewModel.commentsOnBook) { comment in
                    Text(comment.comment)
                        .swipeActions(edge: .trailing) {
                            Button {
                                Task {
                                    if let book {
                                        try await viewModel.deleteComment(comment.id)
                                        try await viewModel.fetchBookComments(book)
                                    }
                                }
                            } label: {
                                Image(systemName: "delete.backward")
                            }
                            .tint(.red)
                        }
                }
            }
            Button {
                Task {
                    if let book {
                        await viewModel.purchaseBook(book)
                    }
                }
            } label: {
                Text("Purchase \(book!.title)")
            }
            Button {
                Task {
                    if let book {
                        await viewModel.addBookToKart(book)
                    }
                }
            } label: {
                Text("Add to cart")
            }
            .navigationBarTitle(book?.title ?? "", displayMode: .inline)
            .onAppear {
                Task {
                    if let book {
                        try await viewModel.fetchBookComments(book)
                    }
                }
            }
        }
    }
}
