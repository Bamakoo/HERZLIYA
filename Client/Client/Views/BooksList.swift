//
//  BooksView.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import SwiftUI

struct BooksList: View {
    @StateObject private var viewModel = BooksViewModel(networkManager: SettingNetworkManager(httpClient: Networking()))
    @State private var selection: Book?
    
    var body: some View {
        NavigationSplitView {
            List(viewModel.books, selection: $selection) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
            }
            .navigationTitle("Books")
            .listStyle(.grouped)
            
        } detail: {
            if let book = selection {
                BookDetail(book: book)
            } else {
                Text("Pick a book")
            }
        }
        .onAppear() {
            Task {
                await viewModel.fetchBooks()
            }
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksList()
    }
}
