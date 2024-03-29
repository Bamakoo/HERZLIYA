//
//  BookDetail.swift
//  Client
//
//  Created by Emma Gaubert on 21/02/2023.
//

import SwiftUI

struct BookDetail: View {

    @Binding var book: Book?
    @StateObject private var viewModel = BooksViewModel(networkManager: BooksNetworkManager(httpClient: Networking()))
    @State private var isDisplaying = false

    var body: some View {
        ScrollView {
            Image(systemName: "book")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            if let book {
                Text(book.title)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text("by \(book.author)")
                    .font(.headline)
                    .fontWeight(.thin)
            }
            Spacer(minLength: 20)
            HStack(alignment: .center, spacing: 20) {
                if let book,
                   let bookRating = book.rating {
                    HStack(alignment: .center, spacing: 2) {
                        ForEach(1..<5 + 1, id: \.self) { value in
                            Image(systemName: "star")
                                .symbolVariant(value <= Int(bookRating) ? .fill : .none)
                                .foregroundColor(.yellow)
                        }
                    }
                    Text(String(bookRating/2)).foregroundColor(Color.secondary) +
                    Text("/5.0").foregroundColor(Color(uiColor: .tertiaryLabel))
                }
            }
            Spacer(minLength: 30)
            Button {
                isDisplaying.toggle()
            } label: {
                switch viewModel.commentsOnBook.count {
                case 0:
                    Text("Be the first to comment")
                case let numberOfComments where numberOfComments == 1:
                    Text("Display 1 comment")
                case let numberOfComments where numberOfComments > 1:
                    Text("Display \(viewModel.commentsOnBook.count) comments")
                case _:
                    Text("Something went wrong")
                }
            }
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .center, spacing: 15) {
                    Text("Genre")
                        .foregroundColor(Color.secondary)
                    if let book {
                        Text(book.genre.rawValue)
                            .fontWeight(.semibold)
                    }
                }
                Spacer(minLength: 0)
                Divider()
                Spacer(minLength: 0)
                VStack(alignment: .center, spacing: 15) {
                    Text("Pages")
                        .foregroundColor(Color.secondary)
                    Text("24 pages")
                        .fontWeight(.semibold)
                }
                Spacer(minLength: 0)
                Divider()
                Spacer(minLength: 0)
                VStack(alignment: .center, spacing: 15) {
                    Text("Time")
                        .foregroundColor(Color.secondary)
                    Text("328 min")
                        .fontWeight(.semibold)
                }
            }
            .padding([.bottom, .top], 20)
            .padding([.leading, .trailing], 30)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(uiColor: .tertiarySystemFill))
            }
            .padding()
            Spacer(minLength: 30)
            if let book {
                Text(book.descritpion)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.secondary)
                    .padding([.leading, .trailing], 30)
            }
            if let book {
                CustomButton(book: book)
                    .padding([.bottom, .top], 20)
                    .padding([.leading, .trailing], 30)
            }
        }
        .sheet(isPresented: $isDisplaying) {
            if let book {
                BookCommentsView(book: book)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        if let book {
                            await viewModel.likeABook(book)
                        }
                    }
                } label: {
                    Image(systemName: "heart.fill")
                }
                .tint(.red)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    Task {
                        if let book {
                            await viewModel.addBookToKart(book)
                        }
                    }
                } label: {
                    Image("shopping-cart")
                }
            }
        }
        .onAppear {
            Task {
                if let book {
                    try await viewModel.fetchBookComments(book)
                }
            }
        }
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        BookDetail(book: Binding.constant(Book(title: "jsfvsdfv",
                                               author: "hello",
                                               price: 12,
                                               state: .acceptable,
                                               descritpion: """
Le Lorem Ipsum est simple
ment du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum
    est le faux texte standard de
    l'imprimerie depuis les années 1500, quand un imprimeur anonym
e assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de
texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique,                           sans que son contenu n'en soit modifié. Il a été
    popularisé dans les années 19
60 grâce à la ven
te de feuilles Letraset contenant des passages du L
orem Ipsum, et, plus récemment, par son inclusion dans des applications de mise en page de texte, comme Aldus
    PageMaker.
""",
                                               genre: .action,
                                               rating: 10)))
    }
}
