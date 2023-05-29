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
                    Image(systemName: "house.circle.fill")
                }
            BooksList()
                .tabItem {
                    Image(systemName: "books.vertical.circle.fill")
                }
            CreateBookView()
                .tabItem {
                    Image(systemName: "plus.square")
                }
            ProfileSwitch()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                }

            KartView()
                .tabItem {
                    Image(systemName: "cart")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
