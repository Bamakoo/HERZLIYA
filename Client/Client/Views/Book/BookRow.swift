//
//  BookRow.swift
//  Client
//
//  Created by Emma Gaubert on 21/02/2023.
//

import SwiftUI

struct BookRow: View {

    var book: Book
    var price: String {
        book.price.formatted(.currency(code: "EUR"))
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(book.genre.image)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 30)
                    .fontWeight(.thin)
                    .foregroundStyle(.primary)
                    .padding([.trailing], 8)
                Spacer()
                Text(price)
                    .font(.title3.monospacedDigit())
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                    .padding([.top, .bottom], 4)
                    .padding([.leading, .trailing], 8)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            Spacer(minLength: 24)
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                Text(book.author)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
