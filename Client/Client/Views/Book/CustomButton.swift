//
//  CustomButton.swift
//  Client
//
//  Created by Emma Gaubert on 12/09/2023.
//

import SwiftUI

struct CustomButton: View {

    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))

    let book: Book

    var body: some View {
        Button {
            Task {
                    await viewModel.purchaseBook(book)
            }
        } label: {
            Spacer()
            Text("Buy now for \(book.price.formatted(.currency(code: "EUR")))".uppercased())
                .font(.system(.title2, design: .rounded ))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.orange))
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(book: Book(title: "jnnsjfsvndifvnsdifv",
                                author: "xfvhivhqfvhqdifvhqdfv",
                                price: 12,
                                state: .acceptable,
                                descritpion: "sjnvsfvndfjvn",
                                genre: .action,
                                rating: 23))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
