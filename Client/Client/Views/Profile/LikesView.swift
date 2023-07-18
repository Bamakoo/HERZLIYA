//
//  FavoritesView.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import SwiftUI

struct LikesView: View {
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var selection: Book?
    var body: some View {
        NavigationSplitView {
            List(viewModel.likedBooks, selection: $selection) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
            }
            .navigationTitle("My liked books")
            .listStyle(.grouped)
        } detail: {
            if selection != nil {
                BookDetail(book: $selection)
            } else {
                Text("Pick a book")
            }
        }
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
