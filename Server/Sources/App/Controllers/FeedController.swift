import Fluent
import Vapor
import Foundation

struct FeedController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let tokenProtected = routes.grouped(UserToken.authenticator())
        tokenProtected.get("feed", use: feed)
    }
    
    func feed(req: Request) async throws -> [FeedElement] {
        var elements = [FeedElement]()
        
        let likes = try await Like.query(on: req.db).all()
        for like in likes {
            let likeElement = FeedElement(type: .like(GetLike(id: try like.requireID(),
                                                          userID: like.$user.id,
                                                          bookID: like.$book.id,
                                                          bookTitle: nil,
                                                          username: nil)))
            elements.append(likeElement)
        }
        
        let comments = try await Comment.query(on: req.db).all()
        for comment in comments {
            let commentElement = FeedElement(type: .comment(GetComment(id: try comment.requireID(),
                                                                   comment: comment.comment,
                                                                   bookID: comment.$book.id,
                                                                   userID: comment.$user.id,
                                                                   username: nil,
                                                                   bookTitle: nil)))
            elements.append(commentElement)
        }
        
        let ratings = try await Rating.query(on: req.db).all()
        for rating in ratings {
            let ratingElement = FeedElement(type: .rating(RatingDTO(id: try rating.requireID(),
                                                                bookID: rating.$book.id,
                                                                rating: rating.rating,
                                                                bookTitle: nil,
                                                                username: nil)))
            elements.append(ratingElement)
        }
        
        let books = try await Book.query(on: req.db).all()
        for book in books {
            let bookElement = FeedElement(type: .book(GetBook(id: try book.requireID(),
                                                          descritpion: book.description,
                                                          genre: book.genre,
                                                          rating: book.rating,
                                                          title: book.title,
                                                          author: book.author,
                                                          price: book.price,
                                                          state: book.state)))
            elements.append(bookElement)
        }
        
        let users = try await User.query(on: req.db).all()
        for user in users {
            let userElement = FeedElement(type: .user(GetUser(id: try user.requireID(),
                                                          username: user.username,
                                                          favoriteBook: user.favoriteBook,
                                                          country: user.country,
                                                          city: user.city,
                                                          favoriteAuthor: user.favoriteAuthor)))
            elements.append(userElement)
        }
        return elements
    }
}
