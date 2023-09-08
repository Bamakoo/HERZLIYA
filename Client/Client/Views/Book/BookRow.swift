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
        HStack(alignment: .center) {
            Image(book.genre.image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 30, height: 30)
                .fontWeight(.thin)
                .foregroundStyle(.primary)
                .padding([.trailing], 8)
            VStack(alignment: .leading, spacing: 5) {
                Text(book.genre.rawValue.capitalized)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                Text(book.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .fontWeight(.bold)
                Text("by \(book.author)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                HStack(alignment: .center, spacing: 2) {
                    if let bookRating = book.rating {
                        ForEach(1..<5 + 1, id: \.self) { value in
                            Image(systemName: "star")
                                .symbolVariant(value <= Int(bookRating) ? .fill : .none)
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
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
    }
}
