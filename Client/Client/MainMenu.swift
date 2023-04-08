//
//  ContentView.swift
//  Client
//
//  Created by Emma Gaubert on 17/02/2023.
//
// TODO: add environment objects
import SwiftUI

struct MainMenu: View {
    var body: some View {
        TabView {
            BooksList()
                .tabItem {
                    Label("Books", systemImage: "books.vertical.circle.fill")
                }
            CreateBookView()
                .tabItem {
                    Label("Add Book", systemImage: "plus.circle")
                }
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
            LoginChoiceScreen()
                .tabItem {
                    Label("Sign in", systemImage: "person.badge.shield.checkmark.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
