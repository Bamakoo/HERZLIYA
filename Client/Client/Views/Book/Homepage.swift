//
//  Homepage.swift
//  Client
//
//  Created by Emma Gaubert on 29/05/2023.
//

import SwiftUI

struct Homepage: View {
    @StateObject private var viewModel = HomepageViewModel(networkManager: HomepageNetworkManager(httpClient: Networking()))
    @State private var selectedBook: GetBook?
    @State private var filterByUsername: String = ""
    var body: some View {
        NavigationSplitView {
            List(viewModel.isSorting ? viewModel.sortedBooks : viewModel.books, selection: $selectedBook) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
                .swipeActions(edge: .trailing) {
                    Button {
                        Task { await viewModel.likeABook(book) }} label: {
                        Image(systemName: "heart")
                    }
                }
            }
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
            .listStyle(.grouped)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Homepage")
        } detail: {
            if selectedBook != nil {
                BookDetail(book: $selectedBook)
            } else {
                Text("Pick a book")
            }
        }
        .task {
            await viewModel.fetchBooks()
        }
        .refreshable {
            viewModel.isSorting.toggle()
            await viewModel.fetchBooks()
            print("feeling fresh")
        }
    }
}

struct Homeage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
