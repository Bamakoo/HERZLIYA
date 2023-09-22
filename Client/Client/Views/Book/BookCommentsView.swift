//
//  BookCommentsView.swift
//  Client
//
//  Created by Emma Gaubert on 15/09/2023.
//

import SwiftUI

struct BookCommentsView: View {
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @Environment(\.dismiss) private var dismiss

    let book: Book
    var body: some View {
        List(viewModel.commentsOnBook) { comment in
            Text(comment.comment)
                .swipeActions(edge: .trailing) {
                    Button {
                        Task {
                                try await viewModel.deleteComment(comment.id)
                                try await viewModel.fetchBookComments(book)
                        }
                    } label: {
                        Image(systemName: "delete.backward")
                    }
                    .tint(.red)
                }
        }
        Button("Dismiss") {
            dismiss()
        }
        .onAppear {
            Task {
                try await viewModel.fetchBookComments(book)
            }
        }
    }
}

struct BookCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        BookCommentsView(book: Book(title: "isdf hfidfhvfidsuhvf",
                                    author: "divhidhvsdiuvhsdiufvhs",
                                    price: 120,
                                    state: .acceptable,
                                    descritpion: "klhhuiogggyugugyuguy",
                                    genre: .action, rating: 1.2))
    }
}
