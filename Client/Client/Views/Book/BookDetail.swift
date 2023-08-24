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
    @State private var rating: Double = 0

    var body: some View {
        Form {
            Section {
            if let book {
                
                HStack {
                    Image(systemName: "book")
                    Text("Title: \(book.title)")
                }
                HStack {
                    Image(systemName: "person")
                    Text("Author: \(book.author)")
                }
                HStack {
                    Image(systemName: "dollarsign")
                    Text("Price: \(book.price)")
                }
                HStack {
                    Image(systemName: book.state.image)
                    Text("State: \(book.state.rawValue)")
                }
                if let bookRating = book.rating {
                    HStack {
                        Image(systemName: "number")
                        Text("Rating \(bookRating)")
                    }
                }
            }
            } header: {
                Text("About")
            }
            Section {
                if let book {
                    Text(book.descritpion)
                }
            } header: {
                Text("Description")
            }
            Section {
                    Slider(value: $rating, in: 0 ... 10, step: 1) {
                        Text("Slider")
                    } minimumValueLabel: {
                        Text("0").font(.title2).fontWeight(.thin)
                    } maximumValueLabel: {
                        Text("10").font(.title2).fontWeight(.thin)
                    }
                    .tint(.red)
                Button {
                    Task {
                        if let book {
                            try await viewModel.rateBook(book, rating)
                        }
                    }
                } label: {
                    Spacer()
                    if let book {
                        Text("Rate \(book.title) \(String(rating))")
                    }
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
            }
             header: {
                Text("Rating")
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
