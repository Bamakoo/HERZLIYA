//
//  Homepage.swift
//  Client
//
//  Created by Emma Gaubert on 29/05/2023.
//

import SwiftUI

struct BookList: View {

    @StateObject private var viewModel = HomepageViewModel()
    @State private var selectedBook: Book?
    @State private var filterByUsername: String = ""

    var body: some View {
        NavigationSplitView {
            List(viewModel.books, selection: $selectedBook) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
                .listRowViewModifier()
                .swipeActions(edge: .trailing) {
                    Button {
                        Task {
                            await viewModel.likeABook(book)
                        }
                    } label: {
                        Image(systemName: "heart")
                    }
                    .tint(.red)
                }
                .swipeActions(edge: .leading) {
                    Button {
                        Task {
                            await viewModel.addBookToKart(book)
                        }
                    } label: {
                        Image(systemName: "cart.badge.plus")
                    }
                    .tint(Color.blue)
                }
            }
            .listViewModifier()
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button("Sort by title ascending") {
                            Task {
                                viewModel.selectedSort = .title
                                viewModel.sortAscending = true
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by title descending") {
                            Task {
                                viewModel.selectedSort = .title
                                viewModel.sortAscending = false
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by author descending") {
                            Task {
                                viewModel.selectedSort = .author
                                viewModel.sortAscending = false
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by author ascending") {
                            Task {
                                viewModel.selectedSort = .author
                                viewModel.sortAscending = true
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by genre descending") {
                            Task {
                                viewModel.selectedSort = .genre
                                viewModel.sortAscending = false
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by genre ascending") {
                            Task {
                                viewModel.selectedSort = .genre
                                viewModel.sortAscending = true
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by price descending") {
                            Task {
                                viewModel.selectedSort = .price
                                viewModel.sortAscending = false
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by price ascending") {
                            Task {
                                viewModel.selectedSort = .price
                                viewModel.sortAscending = true
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by state descending") {
                            Task {
                                viewModel.selectedSort = .state
                                viewModel.sortAscending = false
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by state ascending") {
                            Task {
                                viewModel.selectedSort = .state
                                viewModel.sortAscending = true
                                await viewModel.sort()
                            }
                        }
                    }
                label: {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                }
                }
            }
            .navigationTitle("Books")
        } detail: {
            if selectedBook != nil {
                BookDetail(book: $selectedBook)
            } else {
                Text("Pick a book")
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchBooks()
            }
        }
        .refreshable {
            await viewModel.fetchBooks()
        }
    }
}

struct Homeage_Previews: PreviewProvider {
    static var previews: some View {
        BookList()
    }
}
