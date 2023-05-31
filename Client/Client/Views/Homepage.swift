//
//  Homepage.swift
//  Client
//
//  Created by Emma Gaubert on 29/05/2023.
//

import SwiftUI

struct Homepage: View {
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var selectedBook: GetBook?
    var body: some View {
        NavigationSplitView {
            List(viewModel.books, selection: $selectedBook) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
            }
            .toolbarRole(.browser)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                                Menu {
                                    Menu("Display") {
                                        Button("Books") {
                                            print("Displaying books")
                                        }
                                        Button("Comments") {
                                            print("Displaying comments")
                                        }
                                        Button("Ratings") {
                                            print("Displaying comments")
                                        }
                                    }
                                    Menu("Sort") {
                                        Button("By title") {
                                            print("Displaying sorted XYZ by title")
                                        }
                                        Button("By Author") {
                                            print("Displaying sorted XYZ by title")
                                        }
                                        Button("Price") {
                                            print("Sorting by price")
                                        }
                                    }
                                    Menu("Filter") {
                                        Button("By title") {
                                            print("Displaying sorted XYZ by title")
                                        }
                                        Button("By Author") {
                                            print("Displaying sorted XYZ by title")
                                        }
                                        Button("Price") {
                                            print("Sorting by price")
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
