//
//  UpdateProfile.swift
//  Client
//
//  Created by Emma Gaubert on 12/06/2023.
//

import SwiftUI

struct UpdateProfile: View {
    @State private var changeMyPassword = false

    var body: some View {
        Button("Delete my profile") {
            print("profile deleted")
        }
        Button("Disconnect") {
            print("Disconnected")
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
