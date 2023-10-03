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
                    if let commentUsername = comment.username,
                       let commentBookTitle = comment.bookTitle {
                        HStack {
                            Image(systemName: "speaker.wave.3")
                                .fontWeight(.thin)
                                .foregroundStyle(.primary)
                                .padding([.trailing], 8)
                            VStack {
                                Text("\(commentUsername) commented on \(commentBookTitle)")
                                    .font(.title3)
                                    .foregroundStyle(.primary)
                                    .fontWeight(.regular)
                                Text(comment.comment)
                                    .font(.footnote)
                                    .fontWeight(.medium)
                            }
                        }
                    }
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
