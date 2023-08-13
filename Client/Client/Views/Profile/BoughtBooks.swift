//
//  MyPurchases.swift
//  Client
//
//  Created by Emma Gaubert on 02/04/2023.
//

import SwiftUI

struct MyPurchases: View {

    @StateObject private var viewModel = ProfileViewModel()
    @State private var selection: Book?

    var body: some View {
            List(viewModel.purchasedBooks, selection: $selection) { book in
                NavigationLink(destination: BookDetail(book: Binding.constant(book))) {
                    BookRow(book: book)
                }
            }
            .navigationTitle("Books I've Purchased")
            .listStyle(.grouped)
        .onAppear {
            Task {
                try await viewModel.fetchPurchasedBooks()
            }
        }
    }
}
struct MyPurchases_Previews: PreviewProvider {
    static var previews: some View {
        MyPurchases()
    }
}
