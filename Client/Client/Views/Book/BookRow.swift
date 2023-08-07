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
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .padding(.all, 20)

            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .foregroundColor(.white)
                Text(book.author)
                    .font(.system(size: 12, weight: .bold, design: .default))
                    .foregroundColor(.gray)
                HStack {
                    Text("$" + String.init(format: "%0.2f", book.price))
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 8)
                }
            }.padding(.trailing, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .modifier(CardModifier())
        .padding(.all, 10)
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}
