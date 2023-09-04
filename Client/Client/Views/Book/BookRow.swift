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
                   Image(systemName: "book")
                       .resizable()
                       .aspectRatio(1, contentMode: .fit)
                       .frame(width: 30)
                       .fontWeight(.heavy)
                       .padding([.trailing], 8)
                   VStack(alignment: .leading) {
                       Text(book.title)
                           .font(.title2)
                           .fontWeight(.medium)
                           .foregroundStyle(.primary)
                       Text(book.author)
                           .font(.headline)
                           .fontWeight(.regular)
                           .foregroundStyle(.secondary)
                   }
                   Spacer()
            Text(price)
                       .font(.title2.monospacedDigit())
                       .fontWeight(.medium)
                       .foregroundStyle(.primary)
               }
           }
       }
