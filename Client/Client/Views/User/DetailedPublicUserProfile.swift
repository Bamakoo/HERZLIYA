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
            VStack(alignment: .center, spacing: 12) {
                Text(user.username)
                    .font(.title)
                    .padding(.bottom, 10)
                HStack(alignment: .center) {
                    Image(systemName: "globe.desk")
                    Text("Lives in \(user.city), \(user.country)")
                        .font(.headline)
                }
                HStack(alignment: .center) {
                    Image(systemName: "heart")
                    Text("My favorite author is \(user.favoriteAuthor)")
                }
                HStack {
                    Image(systemName: "brain.head.profile")
                    Text("My favorite book is \(user.favoriteBook)")
                }
            }
        }
    }
}
