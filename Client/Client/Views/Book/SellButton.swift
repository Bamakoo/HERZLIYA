//
//  SellButton.swift
//  Client
//
//  Created by Emma Gaubert on 13/09/2023.
//

import SwiftUI

struct SellButton: View {
    @StateObject var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            Task {
                await viewModel.createBook()
            }
        } label: {
            Spacer()
            Text("Sell".uppercased())
                .font(.system(.title2, design: .rounded ))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.purple))
    }
}

struct SellButton_Previews: PreviewProvider {
    static var previews: some View {
        SellButton()
    }
}
