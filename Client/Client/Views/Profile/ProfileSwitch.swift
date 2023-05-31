//
//  ProfileSwitch.swift
//  Client
//
//  Created by Emma Gaubert on 27/05/2023.
//

import SwiftUI

struct ProfileSwitch: View {
    @StateObject private var viewModel = UsersViewModel(networkManager: UserNetworkManager(httpClient: Networking()))
    // @State private var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    // @State private var isLoggedIn = User.isLoggedIn
    var body: some View {
        if viewModel.isLoggedIn { UserProfileView() } else { Oups() }
    }
}

struct ProfileSwitch_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSwitch()
    }
}