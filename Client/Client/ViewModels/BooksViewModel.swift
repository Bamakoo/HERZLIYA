//
//  BooksViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation
@MainActor final class BooksViewModel: ObservableObject {

    @Published var title = ""
    @Published var author = ""
    @Published var description = ""
    @Published var genre: BookGenre = .action
    @Published var state: BookState = .acceptable
    @Published var price = 0
    @Published var status: BookStatus = .available
    @Published var books = [Book]()
    @Published var booksByUsersFavoriteAuthor = [Book]()
    @Published var searchText: String = ""
    @Published var searchResults = [Book]()
    @Published var commentsOnBook = [Comment]()

    private let networkManager: BooksNetworkManager

    init(networkManager: BooksNetworkManager) {
        self.networkManager = networkManager
    }

    func rateBook(_ book: Book, _ rating: Double) async throws {
        do {
            guard let bookID = book.id else {
                return
            }
            let rating = Rating(id: nil, userID: nil, bookID: bookID, rating: Float(rating), bookTitle: nil, username: nil)
            try await UseCase.Books.rate(rating)
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchBookComments(_ book: Book) async throws {
        do {
            guard let bookID = book.id else {
                return
            }
            commentsOnBook = try await UseCase.Comments.fetchCommentsOnBook(bookID)
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteComment(_ commentID: UUID?) async throws {
        do {
            guard let commentID else {
                return
            }
            try await UseCase.Comments.delete(commentID)
        } catch {
            print(error.localizedDescription)
        }
    }

    func commentOnBook(_ book: Book, _ comment: String) async throws {
        do {
            guard let bookID = book.id else {
                return
            }
            let newComment = PostComment(comment: comment, bookID: bookID)
            try await UseCase.Comments.commentOnBook(newComment)
        } catch {
            print(error.localizedDescription)
        }
    }

    func addBookToKart(_ book: Book) async {
        do {
            guard let bookID = book.id else {
                return
            }
            try await UseCase.Books.addBookToKart(bookID)
        } catch {
            print(error.localizedDescription)
        }
    }

    func search() async {
        do {
            guard !searchText.isEmpty else { return }
            searchResults = try await networkManager.searchBooks(searchText)
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchBooks() async {
        do {
            books = try await UseCase.Books.fetch()
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchBooksByGenre(_ bookGenre: BookGenre) async {
        do {
            books = try await networkManager.fetchBooksByCategory(bookGenre)
        } catch {
            print(error.localizedDescription)
        }
    }

    func createBook() async {
        do {
            let newBook: CreateBookData = CreateBookData(title: title,
                                                         author: author,
                                                         description: description,
                                                         genre: genre,
                                                         state: state,
                                                         status: status,
                                                         price: price)
            try await UseCase.Books.create(newBook)
        } catch {
            print(error.localizedDescription)
        }
    }

    func purchaseBook(_ book: Book) async {
        do {
            guard let bookID = book.id else {
                return
            }
            try await UseCase.Books.buyBook(bookID)
        } catch {
            print(error.localizedDescription)
        }
    }
}
