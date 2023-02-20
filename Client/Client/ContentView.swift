//
//  ContentView.swift
//  Client
//
//  Created by Emma Gaubert on 17/02/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BooksView()
                .tabItem {
                    Label("Books", systemImage: "books.vertical")
                }

            AuthorsView()
                .tabItem {
                    Label("Authors", systemImage: "person.circle")
                }
            
            CreateAuthorView()
                .tabItem {
                    Label("Add author", systemImage: "person.fill.badge.plus")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
