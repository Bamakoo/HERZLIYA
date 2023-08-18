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
        if let comment,
           let commentUsername = comment.username,
           let commentBookTitle = comment.bookTitle {
            Text("\(commentUsername) commented on \(commentBookTitle)")
            Text(comment.comment)
        }
    }
}
