//
//  FeaturedItem.swift
//  Client
//
//  Created by Emma Gaubert on 29/08/2023.
//

import SwiftUI

struct FeaturedItem: View {
    var element: Element
    var homepageCategory: HomepageCategory
        var body: some View {
            VStack(alignment: .leading) {
                Image(systemName: homepageCategory.image)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 155, height: 155)
                    .cornerRadius(5)
                Text("hello world")
                    .foregroundColor(.primary)
                    .font(.caption)
            }
            .padding(.leading, 15)
        }
}
