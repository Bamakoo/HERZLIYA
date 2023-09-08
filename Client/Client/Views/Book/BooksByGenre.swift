//
//  BooksView.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//
import SwiftUI
struct BooksByGenre: View {

    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var selectedBook: Book?
    @State private var selectedBookGenre: BookGenre?
    @State private var showSheet = false
    @State private var showSearch = false
    @Environment(\.isSearching) private var isSearching

    var body: some View {
        NavigationSplitView {
            List(BookGenre.allCases, selection: $selectedBookGenre) { genre in
                NavigationLink(value: genre) {
                    Label(genre.title, image: genre.image)
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
                NavigationLink(destination: BookDetail(book: Binding.constant(book))) {
                    BookRow(book: book)
                }
            }
            .navigationTitle(selectedBookGenre?.title ?? "Books")
            .listStyle(.grouped)
            .onChange(of: selectedBookGenre) { _ in
                Task {
                    guard let selectedBookGenre else { return }
                    await viewModel.fetchBooksByGenre(selectedBookGenre)
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
                guard let selectedBookGenre else { return }
                await viewModel.fetchBooksByGenre(selectedBookGenre)
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
                            await viewModel.fetchBooksByGenre(selectedBookGenre)
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
