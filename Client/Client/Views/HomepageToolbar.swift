//
//  HomepageToolbar.swift
//  Client
//
//  Created by Emma Gaubert on 07/06/2023.
//

import SwiftUI

struct HomepageToolbar: ToolbarContent {
    @StateObject private var viewModel = HomepageViewModel()
    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Menu {
                Button("Sort by title ascending") {
                    viewModel.selectedSort = .title
                    Task {
                        await viewModel.sort()
                    }
                }
                Button("Sort by title descending") {
                    viewModel.selectedSort = .title
                    Task {
                        await viewModel.sort()
                    }
                }
                Button("Sort by author descending") {
                    viewModel.selectedSort = .author
                    Task {
                        await viewModel.sort()
                    }
                }
                Button("Sort by author ascending") {
                    viewModel.selectedSort = .author
                    Task {
                        await viewModel.sort()
                    }
                }
                Button("Sort by genre descending") {
                    viewModel.selectedSort = .genre
                    Task {
                        await viewModel.sort()
                    }
                }
                Button("Sort by genre ascending") {
                    viewModel.selectedSort = .genre
                    Task {
                        await viewModel.sort()
                    }
                }
                Button("Sort by price descending") {
                    viewModel.selectedSort = .price
                    Task {
                        await viewModel.sort()
                    }
                }
                Button("Sort by price ascending") {
                    viewModel.selectedSort = .price
                    Task {
                        await viewModel.sort()
                    }
                }
                Button("Sort by state descending") {
                    viewModel.selectedSort = .state
                    Task {
                        await viewModel.sort()
                    }
                }
                Button("Sort by state ascending") {
                    viewModel.selectedSort = .state
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
}
