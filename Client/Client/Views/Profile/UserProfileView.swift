//
//  UserProfileView.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject private var viewModel = UsersViewModel(networkManager: UserNetworkManager(httpClient: Networking()))
    var linkNames = LinkNames.allCases
    var body: some View {
        VStack(spacing: 0) {
            ForEach(linkNames) { linkName in
                ProfileRow(linkName: linkName.rawValue)
            }
            Spacer()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
