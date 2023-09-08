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
            BookList()
                .tabItem {
                    Label("Books", image: "book")
                }
            CreateBookView()
                .tabItem {
                    Label("Sell", image: "add")
                }
            ProfileSwitch()
                .tabItem {
                    Label("Profile", image: "user")
                }
            More()
                .tabItem {
                    Label("More", image: "more")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
