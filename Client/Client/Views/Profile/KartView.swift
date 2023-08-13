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
            List(viewModel.kartBooks, selection: $selection) { book in
                NavigationLink(destination: BookDetail(book: Binding.constant(book))) {
                    BookRow(book: book)
                }
                .swipeActions(edge: .trailing) {
                    Button {
                        Task {
                            try await viewModel.removeBookFromKart(book)
                            try await viewModel.getBooksInKart()
                        }
                    } label: {
                        Image(systemName: "cart.fill.badge.minus")
                    }
                    .tint(.red)
                }
                .swipeActions(edge: .leading) {
                    Button {
                        Task {
                            try await viewModel.buyBook(book)
                            try await viewModel.getBooksInKart()
                        }
                    } label: {
                        Image(systemName: "dollarsign")
                    }
                    .tint(.mint)
                }
            }
            .onAppear {
                Task {
                    try await viewModel.getBooksInKart()
                }
            }
            .navigationTitle("My Cart")
            .listStyle(.grouped)
    }
}

struct KartView_Previews: PreviewProvider {
    static var previews: some View {
        KartView()
    }
}
