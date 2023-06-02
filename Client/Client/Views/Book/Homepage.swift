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
                        Button(WhatToDisplay.books.rawValue) {
                            viewModel.selectedDisplay = .books
                        }
                        Button(WhatToDisplay.comments.rawValue) {
                            viewModel.selectedDisplay = .comments
                        }
                        Button(WhatToDisplay.ratings.rawValue) {
                            viewModel.selectedDisplay = .ratings
                        }
                        Button(WhatToDisplay.users.rawValue) {
                            viewModel.selectedDisplay = .users

                        }
                        if viewModel.selectedDisplay == .books {
                            Menu(SortOrFilter.filter.rawValue + " " + viewModel.selectedDisplay.rawValue) {
                                Button("by username") {
                                    viewModel.selectedFilter = .username("")
                                    Task {
                                        await viewModel.filter()
                                    }
                                }
                                Button("by state") {
                                    viewModel.selectedFilter = .state(.acceptable)
                                    print(viewModel.selectedFilter)
                                    Task {
                                        await viewModel.filter()
                                    }
                                }
                                Button("by title") {
                                    viewModel.selectedFilter = .title("")
                                    print(viewModel.selectedFilter)
                                    Task {
                                        await viewModel.filter()
                                    }
                                }
                                Button("by price") {
                                    viewModel.selectedFilter = .price(1)
                                    print(viewModel.selectedFilter)
                                    Task {
                                        await viewModel.filter()
                                    }
                                }
                                Button("by genre") {
                                    viewModel.selectedFilter = .genre(.action)
                                    print(viewModel.selectedFilter)
                                    Task {
                                        await viewModel.filter()
                                    }
                                }
                            }
                        }
                        Menu(HomepageMenuSelector.display.rawValue) {
                            Button(HomepageSubMenuSelector.books.rawValue) {
                                viewModel.selectedMenu = .display
                                viewModel.selectedSubMenu = .books
                                Task {
                                    await viewModel.sort()
                                }
                            }
                            Button(HomepageSubMenuSelector.comments.rawValue) {
                                viewModel.selectedMenu = .display
                                viewModel.selectedSubMenu = .comments
                                Task {
                                    await viewModel.sort()
                                }
                            }
                            Button(HomepageSubMenuSelector.ratings.rawValue) {
                                viewModel.selectedMenu = .display
                                viewModel.selectedSubMenu = .ratings
                                Task {
                                    await viewModel.sort()
                                }
                            }
                            Button(HomepageSubMenuSelector.users.rawValue) {
                                viewModel.selectedMenu = .display
                                viewModel.selectedSubMenu = .users
                                Task {
                                    await viewModel.sort()
                                }
                            }
                        }
                        if viewModel.selectedSubMenu == .books {
                            Menu(HomepageMenuSelector.sort.rawValue) {
                                Button(HomepageSubMenuSelector.title.rawValue) {
                                    viewModel.selectedMenu = .sort
                                    viewModel.selectedSubMenu = .title
                                    Task {
                                        await viewModel.sort()
                                    }
                                }
                                Button(HomepageSubMenuSelector.author.rawValue) {
                                    viewModel.selectedMenu = .sort
                                    viewModel.selectedSubMenu = .author
                                    Task {
                                        await viewModel.sort()
                                    }
                                }
                                Button(HomepageSubMenuSelector.price.rawValue) {
                                    viewModel.selectedMenu = .sort
                                    viewModel.selectedSubMenu = .price
                                    Task {
                                        await viewModel.sort()
                                    }
                                }
                                Button(HomepageSubMenuSelector.state.rawValue) {
                                    viewModel.selectedMenu = .sort
                                    viewModel.selectedSubMenu = .state
                                    Task {
                                        await viewModel.sort()
                                    }
                                }
                            }
                            Menu(HomepageMenuSelector.filter.rawValue) {
                                Button(HomepageSubMenuSelector.title.rawValue) {
                                    viewModel.selectedMenu = .filter
                                    viewModel.selectedSubMenu = .title
                                    Task {
                                        await viewModel.sort()
                                    }
                                }
                                Button(HomepageSubMenuSelector.author.rawValue) {
                                    viewModel.selectedMenu = .filter
                                    viewModel.selectedSubMenu = .author
                                    Task {
                                        await viewModel.sort()
                                    }
                                }
                                Button(HomepageSubMenuSelector.price.rawValue) {
                                    viewModel.selectedMenu = .filter
                                    viewModel.selectedSubMenu = .price
                                    Task {
                                        await viewModel.sort()
                                    }
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
