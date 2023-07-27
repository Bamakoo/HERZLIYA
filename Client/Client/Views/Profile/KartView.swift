//
//  KartView.swift
//  Client
//
//  Created by Emma Gaubert on 23/03/2023.
//

import SwiftUI

struct KartView: View {
    @StateObject private var viewModel = KartViewModel()
    @State private var selection: Book?
    var body: some View {
        NavigationSplitView {
            List(viewModel.kartBooks, selection: $selection) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
                .swipeActions(edge: .trailing) {
                    Button { Task {
                        try await viewModel.removeBookFromKart((book.id)!)
                        try await viewModel.getBooksInKart()
                    }
                    } label: {
                            Image(systemName: "cart.fill.badge.minus")
                        }
                        .tint(.red)
                }
                .swipeActions(edge: .leading) {
                    Button { Task {
                        print("buy this one book")
                    }
                    } label: {
                            Image(systemName: "dollarsign")
                        }
                        .tint(.mint)
                }
            }
            Button {
                print("buy buy buy")
            } label: {
                Text("Purchase all the books in my cart")
            }
            .onAppear {
                Task {
                    try await viewModel.getBooksInKart()
                }
            }
            .navigationTitle("My Cart")
            .listStyle(.grouped)
        } detail: {
            if selection != nil {
                BookDetail(book: $selection)
            } else {
                Text("Pick a book")
            }
        }
    }
}

struct KartView_Previews: PreviewProvider {
    static var previews: some View {
        KartView()
    }
}
