//
//  AllComments.swift
//  Client
//
//  Created by Emma Gaubert on 07/08/2023.
//

import SwiftUI

struct AllComments: View {

    @StateObject private var viewModel = CommentViewModel()
    @State private var selectedComment: Comment?

    var body: some View {
            List(viewModel.allComments, selection: $selectedComment) { comment in
                NavigationLink(destination: CommentBookDetailedView(comment: Binding.constant(comment))) {
                    Label(comment.comment, systemImage: "person.2.wave.2")
                }
            }
        .onAppear {
            Task {
                try await viewModel.fetchAllComments()
            }
        }
    }
}

struct AllComments_Previews: PreviewProvider {
    static var previews: some View {
        AllComments()
    }
}
