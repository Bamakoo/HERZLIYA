//
//  CommentBookDetailedView.swift
//  Client
//
//  Created by Emma Gaubert on 14/08/2023.
//

import SwiftUI

struct CommentBookDetailedView: View {

    @StateObject private var viewModel = CommentViewModel()
    @Binding var comment: Comment?

    var body: some View {
        if let comment {
            Text(comment.comment)
                .onAppear {
                    Task {
                        try await viewModel.fetchSpecificBook(comment.bookID)
                    }
                }
            if let book = viewModel.commentOnBook {
                Text(book.title)
            }
        }
    }
}
