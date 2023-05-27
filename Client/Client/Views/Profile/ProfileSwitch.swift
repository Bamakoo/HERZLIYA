//
//  ProfileSwitch.swift
//  Client
//
//  Created by Emma Gaubert on 27/05/2023.
//

import SwiftUI

struct ProfileSwitch: View {
    @State private var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    var body: some View {
        if isLoggedIn { UserProfileView() } else { Oups() }
    }
}

struct ProfileSwitch_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSwitch()
    }
}
