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
            Homepage()
                .tabItem {
                    Label("Hompeage", systemImage: "house")
                }
            UserMenuView()
                .tabItem {
                    Label("Books", systemImage: "books.vertical")
                }
            CreateBookView()
                .tabItem {
                    Label("Sell", systemImage: "plus.circle")
                }
            ProfileSwitch()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
