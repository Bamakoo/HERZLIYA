//
//  ContentView.swift
//  Client
//
//  Created by Emma Gaubert on 17/02/2023.
//

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
            LikesView()
                .tabItem {
                    Label("Likes", systemImage: "heart.fill")
                }
            CreateAccountView()
                .tabItem {
                    Label("Create an Account", systemImage: "person.fill.badge.plus")
                }
            SignInView(viewModel: SignInViewModel())
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
