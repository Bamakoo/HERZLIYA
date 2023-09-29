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
        Button {
            print("deleted the profile")
            loginManager.isLoggedIn.toggle()
        } label: {
            Text("Delete profile")
        }
        Button {
            @TokenRepository<Any>
            var token: String?
            token = nil
            loginManager.isLoggedIn.toggle()
        } label: {
            Text("Disconnect")
        }
        .buttonStyle(MainButtonStyle())
        Button {
            changeMyPassword.toggle()
        } label: {
            Text("Change passord")
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
