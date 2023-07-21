//
//  BooksView.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//
import SwiftUI
struct BooksList: View {
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var bookGenres: [BookGenre] = BookGenre.allCases
    @State private var selectedBook: Book?
    @State private var selectedBookGenre: BookGenre?
    @State private var showSheet = false
    @State private var showSearch = false
    @Environment(\.isSearching) private var isSearching
    var body: some View {
        NavigationSplitView {
            List(bookGenres, selection: $selectedBookGenre) { genre in
                NavigationLink(value: genre) {
                    Label(genre.title, systemImage: genre.image)
                }
            }
            .listStyle(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSearch.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                    }
                    .sheet(isPresented: $showSearch) {
                        Task {
                            print("Searching ...")
                        }
                    } content: {
                        SearchBook()
                    }
                }
            }
        } content: {
            List(isSearching ? viewModel.searchResults : viewModel.books, selection: $selectedBook) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
            }
            .navigationTitle(selectedBookGenre?.title ?? "Books")
            .listStyle(.grouped)
            .onChange(of: selectedBookGenre) { _ in
                Task {
                    guard let selectedBookGenre else { return }
                    await viewModel.fetchBooksByCategory(selectedBookGenre)
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .submitLabel(.send)
            .onSubmit(of: .search) {
                Task {
                    await viewModel.search()
                    viewModel.books = viewModel.searchResults
                }
            }
            .refreshable {
                print("REFRESHED")
                guard let selectedBookGenre else { return }
                await viewModel.fetchBooksByCategory(selectedBookGenre)
                print("REFRESHED")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus.square")
                    }
                    .sheet(isPresented: $showSheet) {
                        Task {
                            guard let selectedBookGenre else { return }
                            print("vanished")
                            await viewModel.fetchBooksByCategory(selectedBookGenre)
                        }
                    } content: {
                        CreateBookView()
                    }
                }
            }
        } detail: {
            if selectedBook != nil {
                BookDetail(book: $selectedBook)
            } else {
                Text("Pick a book")
            }
        }
    }
}
