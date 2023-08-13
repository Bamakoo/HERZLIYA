//
//  FavoritesView.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import SwiftUI

struct LikesView: View {

    @StateObject private var viewModel = ProfileViewModel()
    @State private var selection: Book?

    var body: some View {
            List(viewModel.likedBooks, selection: $selection) { book in
                NavigationLink(destination: BookDetail(book: Binding.constant(book))) {
                    BookRow(book: book)
                }
            }
            .navigationTitle("My liked books")
            .listStyle(.grouped)
        .onAppear {
            Task {
                try await viewModel.fetchLikedBooks()
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView()
    }
}
