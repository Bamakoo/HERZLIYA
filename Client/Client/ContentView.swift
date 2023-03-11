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
            BooksList()
                .tabItem {
                    Label("Books", systemImage: "books.vertical")
                }
            
            CreateBookView()
                .tabItem {
                    Label("Add Book", systemImage: "plus.circle")
                }
            
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
            
            LikesView()
                .tabItem {
                    Label("Likes", systemImage: "heart.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
