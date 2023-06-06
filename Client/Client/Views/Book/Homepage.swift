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
            List(viewModel.books, selection: $selectedBook) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
            }
            .toolbarRole(.browser)
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
