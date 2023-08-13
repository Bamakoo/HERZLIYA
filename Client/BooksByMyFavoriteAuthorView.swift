//
//  BooksByMyFavoriteAuthorView.swift
//  Client
//
//  Created by Emma Gaubert on 02/04/2023.
//

import SwiftUI

struct BooksByMyFavoriteAuthorView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var selection: Book?

    var body: some View {
            List(viewModel.booksByUsersFavoriteAuthor, selection: $selection) { book in
                NavigationLink(destination: BookDetail(book: Binding.constant(book))) {
                    BookRow(book: book)
                }
            }
            .onAppear {
                Task {
                    try await viewModel.bookByUsersFavoriteAuthor()
                }
            }
            .navigationTitle("Buy books by my favorite author")
            .listStyle(.grouped)
    }
}

struct BooksByMyFavoriteAuthorView_Previews: PreviewProvider {
    static var previews: some View {
        BooksByMyFavoriteAuthorView()
    }
}
