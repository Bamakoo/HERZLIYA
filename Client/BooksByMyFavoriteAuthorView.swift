//
//  BooksByMyFavoriteAuthorView.swift
//  Client
//
//  Created by Emma Gaubert on 02/04/2023.
//

import SwiftUI

struct BooksByMyFavoriteAuthorView: View {
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var selection: Book?
    var body: some View {
        Text("books by the users' favorite author go here")
    }
}

struct BooksByMyFavoriteAuthorView_Previews: PreviewProvider {
    static var previews: some View {
        BooksByMyFavoriteAuthorView()
    }
}
