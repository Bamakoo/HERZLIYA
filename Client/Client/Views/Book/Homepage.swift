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
            }
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button("Sort by title ascending") {
                            viewModel.selectedSort = .title(ascending: true)
                            Task {
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by title descending") {
                            viewModel.selectedSort = .title(ascending: false)
                            Task {
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by author descending") {
                            viewModel.selectedSort = .author(ascending: false)
                            Task {
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by author ascending") {
                            viewModel.selectedSort = .author(ascending: true)
                            Task {
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by genre descending") {
                            viewModel.selectedSort = .genre(ascending: false)
                            Task {
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by genre ascending") {
                            viewModel.selectedSort = .genre(ascending: true)
                            Task {
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by price descending") {
                            viewModel.selectedSort = .price(ascending: false)
                            Task {
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by price ascending") {
                            viewModel.selectedSort = .price(ascending: true)
                            Task {
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by state descending") {
                            viewModel.selectedSort = .state(ascending: false)
                            Task {
                                await viewModel.sort()
                            }
                        }
                        Button("Sort by state ascending") {
                            viewModel.selectedSort = .state(ascending: true)
                            Task {
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
