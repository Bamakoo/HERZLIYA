//
//  BooksView.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import SwiftUI

struct BooksList: View {
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var selection: Book?
    @State var showCreateBookView = false
    
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
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    self.showCreateBookView.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                }.sheet(isPresented: $showCreateBookView) {  CreateBookView()
                }
            }
        }
    }
}
