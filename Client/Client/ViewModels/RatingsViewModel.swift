//
//  RatingsViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 16/08/2023.
//

import Foundation

@MainActor
final class RatingsViewModel: ObservableObject {
    @Published var ratings = [Rating]()
    
    
}
