//
//  PublicProfileView.swift
//  Client
//
//  Created by Emma Gaubert on 14/08/2023.
//

import SwiftUI

struct PublicProfileView: View {
    @Binding var user: FetchUser?
    var body: some View {
        if let user {
            
            Text(user.username)
        }
    }
}
