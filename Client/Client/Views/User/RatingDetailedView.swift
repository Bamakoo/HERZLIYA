//
//  RatingDetailedView.swift
//  Client
//
//  Created by Emma Gaubert on 16/08/2023.
//

import SwiftUI

struct RatingDetailedView: View {
    @Binding var rating: Rating?
    var body: some View {
        if let rating {
            Text(String(rating.rating))
        }
    }
}

