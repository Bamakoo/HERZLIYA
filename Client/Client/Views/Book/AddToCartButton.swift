//
//  AddToCartButton.swift
//  Client
//
//  Created by Emma Gaubert on 13/09/2023.
//

import SwiftUI

struct AddToCartButton: View {
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    let book: Book

    var body: some View {
        Button {
            Task {
                    await viewModel.addBookToKart(book)
            }
        } label: {
            Spacer()
            Text("Add to cart".uppercased())
                .font(.system(.title2, design: .rounded ))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.orange)
        )
    }
}

struct AddToCart_Previews: PreviewProvider {
    static var previews: some View {
        AddToCartButton(book: Book(title: "jnnsjfsvndifvnsdifv",
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
