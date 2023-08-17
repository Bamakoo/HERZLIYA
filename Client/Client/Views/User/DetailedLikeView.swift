//
//  DetailedLikeView.swift
//  Client
//
//  Created by Emma Gaubert on 17/08/2023.
//

import SwiftUI

struct DetailedLikeView: View {
    @Binding var like: Like?
    var body: some View {
        if let like,
            let likeUsername = like.username {
            Text(likeUsername)
        }
    }
}
