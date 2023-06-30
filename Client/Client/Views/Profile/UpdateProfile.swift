//
//  UpdateProfile.swift
//  Client
//
//  Created by Emma Gaubert on 12/06/2023.
//

import SwiftUI

struct UpdateProfile: View {
    var body: some View {
        Button("Delete my profile") {
            print("profile deleted")
        }
        Button("Disconnect") {
            print("Disconnected")
        }
    }
}

struct UpdateProfile_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfile()
    }
}
