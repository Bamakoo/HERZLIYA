//
//  BookRow.swift
//  Client
//
//  Created by Emma Gaubert on 21/02/2023.
//

import SwiftUI

struct BookRow: View {

    var book: Book

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
                           .foregroundStyle(.primary)
                       Text(book.author)
                           .font(.headline)
                           .foregroundStyle(.secondary)
                   }
                   Spacer()
                   Text(String(book.price))
                       .font(.largeTitle.monospacedDigit())
                       .fontWeight(.medium)
                       .foregroundStyle(.primary)
               }
           }
       }
