//
//  MyComments.swift
//  Client
//
//  Created by Emma Gaubert on 03/07/2023.
//

import SwiftUI

struct MyComments: View {
    @StateObject private var viewModel = MyCommentsViewModel()
    var body: some View {
        List(viewModel.myComments) {
            Text($0.comment)
        }
        .onAppear {
            Task {
                try await viewModel.fetchMyComments()
            }
        }
    }
}

struct MyComments_Previews: PreviewProvider {
    static var previews: some View {
        MyComments()
    }
}
