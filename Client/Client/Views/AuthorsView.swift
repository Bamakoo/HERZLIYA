//
//  BooksView.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import SwiftUI

struct AuthorsView: View {
    
    @StateObject private var viewModel = AuthorsViewModel(networkManager: SettingNetworkManager(httpClient: Networking()))
    @State private var isShowingNewAuthor = false 
    
    var body: some View {
        List {
            Section {
                ForEach (viewModel.authors, id: \.self) { author in
                    Text("\(author.firstName ?? "Mark") \(author.lastName ?? "Manson")")
                }
            }
        header: {
            Text("Browse authors")
        }
        }
        .onAppear() {
            Task {
                await viewModel.fetchAuthors()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowingNewAuthor.toggle()
                } label: {
                    Image(systemName: "person.crop.circle.badge.plus")
                }
            }
        }
    }
    
}

struct AuthorsView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
    }
}
