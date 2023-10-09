//
//  CommentsOnMyBooksView.swift
//  Client
//
//  Created by Emma Gaubert on 03/07/2023.
//

import SwiftUI

struct CommentsOnMyBooksView: View {

    @StateObject private var viewModel = MyCommentsViewModel()
    @State private var selectedComment: Comment?

    var body: some View {
        List(viewModel.commentsOnMyBooks, selection: $selectedComment) { comment in
            NavigationLink(destination: CommentBookDetailedView(comment: Binding.constant(comment))) {
                HStack(alignment: .center) {
                    Image(systemName: "speaker.wave.3")
                        .fontWeight(.thin)
                        .foregroundStyle(.primary)
                        .padding([.trailing], 8)
                    Text(comment.comment)
                        .font(.title3)
                        .foregroundStyle(.primary)
                        .fontWeight(.regular)
                }
            }
            .swipeActions(edge: .trailing) {
                Button {
                    Task {
                        try await viewModel.deleteComment(comment.id)
                        try await viewModel.fetchMyComments()
                    }
                } label: {
                    Image(systemName: "delete.backward")
                }
                .tint(.red)
            }
            .swipeActions(edge: .leading) {
                Button {
                    Task {
                        print("change my comments")
                    }
                } label: {
                    Image(systemName: "tornado")
                }
                .tint(.blue)
            }
        }
        .navigationTitle("Comments on my books")
        .onAppear {
            Task {
                try await viewModel.fetchCommentsOnMySoldBooks()
            }
        }
    }
}

struct CommentsOnMyBooksView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsOnMyBooksView()
    }
}
