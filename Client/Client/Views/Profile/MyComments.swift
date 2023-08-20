//
//  MyComments.swift
//  Client
//
//  Created by Emma Gaubert on 03/07/2023.
//

import SwiftUI

struct MyComments: View {

    @StateObject private var viewModel = MyCommentsViewModel()
    @State private var selectedComment: Comment?

    var body: some View {
        List(viewModel.myComments, selection: $selectedComment) { comment in
            NavigationLink(destination: CommentBookDetailedView(comment: Binding.constant(comment))) {
                Label(comment.comment, systemImage: "speaker.wave.3")
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
        }
        .onAppear {
            Task {
                try await viewModel.fetchMyComments()
            }
        }
    }
}

struct MyComments_Previews: PreviewProvider {
    static var previews: some View {
        MyComments()
    }
}
