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
    @State private var fullText: String = "Your comment"
    @State private var rating: Double = 0
    let book: Book

    var body: some View {
        VStack(spacing: 10) {
            Slider(value: $rating, in: 0 ... 10, step: 1) {
                Text("Slider")
            } minimumValueLabel: {
                Text("0").font(.title2).fontWeight(.thin)
            } maximumValueLabel: {
                Text("10").font(.title2).fontWeight(.thin)
            }
            .tint(.orange)
            .padding([.bottom, .top], 30)
            .padding([.leading, .trailing], 30)
            Button {
                Task {
                        try await viewModel.rateBook(book, rating)
                }
            } label: {
                Text("Give book a \(rating) rating".uppercased())
            }
            .buttonStyle(MainButtonStyle())
            TextField("Comment", text: $fullText, prompt: Text("Please input your comment"), axis: .vertical)
                .padding()
                .background(.gray.opacity(0.2))
                .cornerRadius(10.0)
                .padding()
                Button {
                    Task {
                        try await viewModel.commentOnBook(book, fullText)
                        try await viewModel.fetchBookComments(book)
                    }
                } label: {
                    Text("Comment on \(book.title)".uppercased())
                }
                .buttonStyle(MainButtonStyle())
        }
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
