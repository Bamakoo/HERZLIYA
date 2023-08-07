import Fluent
import Vapor

// TODO: refactor to use routes.grouped("me")
// TODO: move all the endpoints related to the user to /me endpoint

struct MyProfileController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        
        let myRoutes = routes.grouped("my")
        
        let tokenAuthenticator = UserToken.authenticator()
        let tokenMiddleware = UserToken.guardMiddleware()
        let tokenAuth = myRoutes.grouped(tokenAuthenticator, tokenMiddleware)
        
        tokenAuth.get(use: getMyProfile)
        tokenAuth.get("likes", use: getMyLikes)
        tokenAuth.get("purchases", use: getMyPurchasedBooks)
        tokenAuth.get("kart", use: myKart)
        tokenAuth.get("sold", use: sold)
        tokenAuth.get("comments", use: myComments)
        tokenAuth.get("favorite-author", use: favoriteAuthor)
        tokenAuth.get("friends", use: myFriends)
    }
    
    /// The function called to get a user's friends
    /// - Parameter req: the incoming request to /friends
    /// - Returns: an array of user object's
    func myFriends(req: Request) async throws -> [User] {
        let user = try req.auth.require(User.self)
        return try await user.$usersFriends.get(on: req.db)
    }
    
    /// When called by the route handler, this function returns an array containing all the comments dropped by a particular user on any book
    /// - Parameter req: the incoming request
    /// - Returns: all the comments a particular user has posted
    func myComments(req: Request) async throws -> [GetComment] {
        
        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }
        
        let comments = try await Comment.query(on: req.db)
            .filter(\.$user.$id == userID)
            .with(\.$user)
            .with(\.$book)
            .all()
        
        return try comments.map { comment in
            try GetComment(id: comment.requireID(), comment: comment.comment, bookID: comment.book.requireID(), userID: comment.user.requireID())
        }
    }
    
    func getMyProfile(req: Request) async throws -> User {
        try req.auth.require(User.self)
    }
    
    func getMyLikes(req: Request) async throws -> [GetBook] {
        let user = try req.auth.require(User.self)
         let books = try await user.$books.get(on: req.db)
         return try books.map { book in
             try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
         }
    }
    
    /// The function called by the controller when the /book/:userID route is called
    /// - Parameter req: the incoming request, sent from the Client to the Server
    /// - Returns: An array of books the user has purchased
    func getMyPurchasedBooks(req: Request) async throws -> [GetBook] {
            let user = try req.auth.require(User.self)
            let books = try await user.$baughtBooks.get(on: req.db)
            return try books.map { book in
                try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
            }
    }
    
    /// This function returns all the books in a user's kart
    /// - Parameter req: the incoming GET request
    /// - Returns: all the books a user has added to her kart
    func myKart(req: Request) async throws -> [GetBook] {
        /// get the user's ID
        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }
        
        guard let kart = try await Kart.query(on: req.db)
            .filter(\.$user.$id == userID)
            .first()
        else {
            throw Abort(.notFound, reason: "unable to find kart")
        }
        
        /// return all the books associated to the kart
        let books = try await kart.$books.get(on: req.db)
        return try books.map { book in
            try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
        }
    }
    
    /// The function called by the controller when the /book/:userID route is called
    /// - Parameter req: the incoming request, received by the server
    /// - Returns: an array of Book objects the user has sold
    func sold(req: Request) async throws -> [GetBook] {
        let user = try req.auth.require(User.self)
        let books = try await user.$soldBooks.get(on: req.db)
        return try books.map { book in
            try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
        }
    }
    
    /// The function that handles all GET requests to the /favorite-authors-books/:userID endpoint
    /// - Parameter req: the incoming HTTP request
    /// - Returns: an array of books written by a user's favorite author
    func favoriteAuthor(req: Request) async throws -> [GetBook] {
        let user = try req.auth.require(User.self)
        let books = try await Book.query(on: req.db).group(.and) { group in
            group.filter(\.$author == user.favoriteAuthor)
                .filter(\.$status == .available)
        } .all()
        return try books.map { book in
            try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
        }
    }
}

