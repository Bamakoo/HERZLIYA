//
//  UserProfileView.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        Text("Displays the User's profile")
        Button {
            print("account created")
        } label: {
            Text("Create an account")
        }
        Button {
            print("user logged in")
        } label: {
            Text("Log in")
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
