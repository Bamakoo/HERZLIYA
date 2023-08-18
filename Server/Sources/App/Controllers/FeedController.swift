import Fluent
import Vapor
import Foundation

enum ElementType: Content {
    case comment(GetComment)
    case rating(RatingDTO)
    case book(GetBook)
    case user(GetUser)
    case like(GetLike)
}

struct Element: Content {
    let type: ElementType
}

struct FeedController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let tokenProtected = routes.grouped(UserToken.authenticator())
        tokenProtected.get("feed", use: feed)
    }
    
    func feed(req: Request) async throws -> [Element] {
        var elements = [Element]()

        let like = try await Like.query(on: req.db).first()
        if let like {
            let likeElement = Element(type: .like(GetLike(id: try like.requireID(), userID: like.$user.id, bookID: like.$book.id, bookTitle: nil, username: nil)))
            elements.append(likeElement)
        } else {
            throw Abort(.notFound)
        }
        
        let comment = try await Comment.query(on: req.db).first()
        if let comment {
            let commentElement = Element(type: .comment(GetComment(id: try comment.requireID(), comment: comment.comment, bookID: comment.$book.id, userID: comment.$user.id, username: nil, bookTitle: nil)))
            elements.append(commentElement)
        } else {
            throw Abort(.notFound)
        }
        
        let rating = try await Rating.query(on: req.db).first()
        if let rating {
            let ratingElement = Element(type: .rating(RatingDTO(id: try rating.requireID(), bookID: rating.$book.id, rating: rating.rating, bookTitle: nil, username: nil)))
            elements.append(ratingElement)
        } else {
            throw Abort(.notFound)
        }
        
        let book = try await Book.query(on: req.db).first()
        if let book {
            let bookElement = Element(type: .book(GetBook(id: try book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)))
            elements.append(bookElement)
        }
        
        let user = try await User.query(on: req.db).first()
        if let user {
            let userElement = Element(type: .user(GetUser(id: try user.requireID(), username: user.username, favoriteBook: user.favoriteBook, country: user.country, city: user.city, favoriteAuthor: user.favoriteAuthor)))
            elements.append(userElement)
        }
        
        return elements
    }
}
