//
//  KartView.swift
//  Client
//
//  Created by Emma Gaubert on 23/03/2023.
//

import SwiftUI

struct KartView: View {
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var selection: Book?
    var body: some View {
        NavigationSplitView {
            List(viewModel.kartBooks, selection: $selection) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
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
