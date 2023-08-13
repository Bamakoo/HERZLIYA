//
//  MyComments.swift
//  Client
//
//  Created by Emma Gaubert on 03/07/2023.
//

import SwiftUI

struct MyComments: View {
    @StateObject private var viewModel = MyCommentsViewModel()

    var body: some View {
        List(viewModel.myComments) { comment in
            Text(comment.comment)
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
