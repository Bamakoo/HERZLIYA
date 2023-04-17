//
//  BooksView.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//
// TODO: clean up all my TODOs
// TODO: finish implementing search function for the NavigationSplitView
// TODO: refactor so there are three views
// TODO: refactor so there are no more @State private var
// TODO: call function with specific genre to filter for
// TODO: filter by state like donut app
import SwiftUI

struct BooksList: View {
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var bookGenres: [BookGenre] = BookGenre.allCases
    @State private var selectedBook: GetBook?
    @State private var selectedBookGenre: BookGenre?
    @State private var searchText: String = ""
    @State private var showSheet = false
    var body: some View {
        NavigationSplitView {
            List(bookGenres, selection: $selectedBookGenre) { genre in
                NavigationLink(value: genre) {
                    Label(genre.title, systemImage: genre.image)
                }
            }
            .navigationTitle("Search books by genre")
            .task {
                await viewModel.fetchBooks()
            }
        } content: {
            List(viewModel.books, selection: $selectedBook) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
            }
            .navigationTitle(selectedBookGenre?.title ?? "Books")
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showSheet) {
                        CreateBookView()
                            .onDisappear {
                                Task {
                                    await viewModel.fetchBooks()
                                }
                            }
                    }
                }
            }
        } detail: {
            if let book = selectedBook {
                BookDetail(book: book)
            } else {
                Text("Pick a book")
            }
        }
        .searchable(text: $searchText, prompt: "Search for your favorite book")
    }
}
