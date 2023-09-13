//
//  ClientApp.swift
//  Client
//
//  Created by Emma Gaubert on 17/02/2023.
//

import SwiftUI

@main
struct ClientApp: App {
    @StateObject var loginManager = LoginManager()

    var body: some Scene {
        WindowGroup {
            MainMenu()
                .environmentObject(loginManager)
        }
    }
}
