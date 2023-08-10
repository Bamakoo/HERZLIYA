//
//  DetailedUserProfile.swift
//  Client
//
//  Created by Emma Gaubert on 08/08/2023.
//

import SwiftUI

struct DetailedUserProfile: View {
    @Binding var user: FetchUser?
    var body: some View {
        if let user {
            Text("Hello, \(user.username)!")
        }
    }
}
