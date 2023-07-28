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
            Text(book!.title)
            Text(String(book!.price))
                .background(Color.white)
            Text(book!.author).bold()
                .background(Color.white)
            Section {
                TextEditor(text: $fullText)
                    .foregroundColor(Color.gray)
                    .lineSpacing(5)
                Button("Comment") {
                    Task {
                        try await viewModel.commentOnBook((book?.id)!, fullText)
                        try await viewModel.getCommentsOnBook((book?.id)!)
                    }
                }
            }
            Section {
                List(viewModel.commentsOnBook) {
                    Text($0.comment)
                }
            }
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
                Text("Add to cart")
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
        .onAppear {
            Task {
                try await viewModel.getCommentsOnBook((book?.id)!)
            }
        }
    }
}
