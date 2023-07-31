import Fluent
import Vapor

struct MyProfileController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tokenProtected = routes.grouped(UserToken.authenticator())
        tokenProtected.get("me") { req -> User in
            try req.auth.require(User.self)
        }
        
        tokenProtected.get("me", "likes") { req ->
            [GetBook] in
            let user = try req.auth.require(User.self)
            let books = try await user.$books.get(on: req.db)
            return try books.map { book in
                try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
            }
        }
        }
    }

