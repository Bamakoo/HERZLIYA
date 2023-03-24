//
//  UsersViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 24/03/2023.
//

import Foundation

final class UsersViewModel: ObservableObject {
    @Published var myProfile: User
    private let networkManager: UserNetworkManager
    init(networkManager: UserNetworkManager) {
        self.networkManager = networkManager
    }
}
