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
                        Menu(HomepageMenuSelector.display.rawValue) {
                            Button(HomepageSubMenuSelector.books.rawValue) {
                                viewModel.selectedMenu = .display
                                viewModel.selectedSubMenu = .books
                                viewModel.sortFilterHandler()
                            }
                            Button(HomepageSubMenuSelector.comments.rawValue) {
                                viewModel.selectedMenu = .display
                                viewModel.selectedSubMenu = .comments
                            }
                            Button(HomepageSubMenuSelector.ratings.rawValue) {
                                viewModel.selectedMenu = .display
                                viewModel.selectedSubMenu = .ratings
                            }
                            Button(HomepageSubMenuSelector.users.rawValue) {
                                viewModel.selectedMenu = .display
                                viewModel.selectedSubMenu = .users
                            }
                        }
                        if viewModel.selectedSubMenu == .books {
                            Menu(HomepageMenuSelector.sort.rawValue) {
                                Button(HomepageSubMenuSelector.title.rawValue) {
                                    viewModel.selectedMenu = .sort
                                    viewModel.selectedSubMenu = .title
                                }
                                Button(HomepageSubMenuSelector.author.rawValue) {
                                    viewModel.selectedMenu = .sort
                                    viewModel.selectedSubMenu = .author
                                }
                                Button(HomepageSubMenuSelector.price.rawValue) {
                                    viewModel.selectedMenu = .sort
                                    viewModel.selectedSubMenu = .price
                                }
                                Button(HomepageSubMenuSelector.state.rawValue) {
                                    viewModel.selectedMenu = .sort
                                    viewModel.selectedSubMenu = .state
                                }
                            }
                            Menu(HomepageMenuSelector.filter.rawValue) {
                                Button(HomepageSubMenuSelector.title.rawValue) {
                                    viewModel.selectedMenu = .filter
                                    viewModel.selectedSubMenu = .title
                                }
                                Button(HomepageSubMenuSelector.author.rawValue) {
                                    viewModel.selectedMenu = .filter
                                    viewModel.selectedSubMenu = .author
                                }
                                Button(HomepageSubMenuSelector.price.rawValue) {
                                    viewModel.selectedMenu = .filter
                                    viewModel.selectedSubMenu = .price
                                }
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
