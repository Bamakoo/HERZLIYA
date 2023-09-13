//
//  ProfileSwitch.swift
//  Client
//
//  Created by Emma Gaubert on 27/05/2023.
//

import SwiftUI

struct ProfileSwitch: View {
    @EnvironmentObject var loginManager: LoginManager
    var body: some View {
        Group {
            if loginManager.isLoggedIn {
                UserProfileView()
            } else {
                Oups()
            }
        }
    }
}

struct ProfileSwitch_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSwitch()
    }
}
