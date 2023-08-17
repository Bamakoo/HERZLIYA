//
//  AllRatings.swift
//  Client
//
//  Created by Emma Gaubert on 07/08/2023.
//

import SwiftUI

struct AllRatings: View {
    @StateObject private var viewModel = RatingsViewModel()
    @State private var selectedRating: Rating?
    var body: some View {
        List(viewModel.ratings, selection: $selectedRating) { rating in
            NavigationLink(destination: RatingDetailedView(rating: Binding.constant(rating))) {
                Label("Rating", systemImage: "number")
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchRatings()
            }
        }
    }
}

struct AllRatings_Previews: PreviewProvider {
    static var previews: some View {
        AllRatings()
    }
}
