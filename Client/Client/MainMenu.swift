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
                    Image(systemName: "house")
                }
            UserMenuView()
                .tabItem {
                    Image(systemName: "books.vertical")
                }
            CreateBookView()
                .tabItem {
                    Image(systemName: "plus")
                }
            ProfileSwitch()
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
