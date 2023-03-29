//
//  UserProfileView.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject private var viewModel = UsersViewModel(networkManager: UserNetworkManager(httpClient: Networking()))

    var body: some View {
        Text("user's profile goes here")
    }
//        .onAppear{
//            Task {
//                viewModel.getMyProfile()
//            }
//        }

}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
