//
//  BooksView.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import SwiftUI

struct BooksList: View {
    
    @StateObject private var viewModel = BooksViewModel(networkManager: SettingNetworkManager(httpClient: Networking()))
    
    var body: some View {
        List {
            Section {
                ForEach (viewModel.books, id: \.self) { book in
                    Text("\(book.title ?? "The subtle art of not giving a fuck") by \(book.author ?? "Mark Manson")")
                }
            }
        header: {
            Text("Available books")
        }
        }
        .onAppear() {
            Task {
                await viewModel.fetchBooks()
            }
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksList()
    }
}
