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
            ProfileSwitch()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
            CreateBookView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 100))
                        .imageScale(.large)
                }
            KartView()
                .tabItem {
                    Label("Cart", systemImage: "cart.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
