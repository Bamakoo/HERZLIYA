//
//  UpdateProfile.swift
//  Client
//
//  Created by Emma Gaubert on 12/06/2023.
//

import SwiftUI

struct UpdateProfile: View {
    @State private var changeMyPassword = false
    @EnvironmentObject var loginManager: LoginManager

    var body: some View {
        Button("Delete my profile") {
            print("profile deleted")
        }
        Button("Disconnect") {
            @TokenRepository<Any>
            var token: String?
            token = nil
            loginManager.isLoggedIn.toggle()
        }
        Button("Change my password") {
            print("changing my password")
            changeMyPassword.toggle()
        }
        .sheet(isPresented: $changeMyPassword) {
            ChangeMyPassword()
        }
    }
}

struct UpdateProfile_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfile()
    }
}
