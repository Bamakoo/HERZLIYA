import Fluent
import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let createNewUser = routes.grouped("users")
        createNewUser.post(use: create)

        let tokenProtectedUsers = routes.grouped(UserToken.authenticator())
                                        .grouped(UserToken.guardMiddleware())
                                        .grouped("users")

        tokenProtectedUsers.get(use: index)
        tokenProtectedUsers.get("likes", use: myLikes)
        tokenProtectedUsers.get("sold", use: mySoldBooks)
        tokenProtectedUsers.get("purchases", use: myPurchasedBooks)
        tokenProtectedUsers.get("favorite-author", use: myFavoriteAuthor)
        tokenProtectedUsers.get("comments", use: myComments)
        tokenProtectedUsers.get("cart", use: myKart)
        tokenProtectedUsers.get("friends", use: myFriends)
        tokenProtectedUsers.patch(use: update)
        tokenProtectedUsers.patch("change-password", use: changePassword)

        tokenProtectedUsers.group(":userID") { user in
            user.delete(use: delete)
        }
    }

    /// The function called to get a user's friends
    /// - Parameter req: the incoming request to /friends
    /// - Returns: an array of user object's
    func myFriends(req: Request) async throws -> [GetUser] {
        let user = try req.auth.require(User.self)
        let users = try await user.$usersFriends.get(on: req.db)
        return try users.map { user in
            try GetUser(id: user.requireID(), username: user.username, favoriteBook: user.favoriteBook, country: user.country, city: user.city, favoriteAuthor: user.favoriteAuthor)
        }
    }

    /// The function that handles all GET requests to the /favorite-authors-books/:userID endpoint
    /// - Parameter req: the incoming HTTP request
    /// - Returns: an array of books written by a user's favorite author
    func myFavoriteAuthor(req: Request) async throws -> [GetBook] {
        let user = try req.auth.require(User.self)
        let books = try await Book.query(on: req.db).group(.and) { group in
            group.filter(\.$author == user.favoriteAuthor)
                .filter(\.$status == .available)
        } .all()
        return try books.map { book in
            try GetBook(id: book.requireID(),
                        descritpion: book.description,
                        genre: book.genre,
                        rating: book.rating,
                        title: book.title,
                        author: book.author,
                        price: book.price,
                        state: book.state)
        }
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
            try GetComment(id: comment.requireID(), comment: comment.comment, bookID: comment.$book.id, userID: comment.$user.id, username: comment.user.username, bookTitle: comment.book.title)
        }
    }
    
    /// The function called by the controller when the /book/:userID route is called
    /// - Parameter req: the incoming request, received by the server
    /// - Returns: an array of Book objects the user has sold
    func mySoldBooks(req: Request) async throws -> [GetBook] {
        let user = try req.auth.require(User.self)
        let books = try await user.$soldBooks.get(on: req.db)
        return try books.map { book in
            try GetBook(id: book.requireID(),
                        descritpion: book.description,
                        genre: book.genre,
                        rating: book.rating,
                        title: book.title,
                        author: book.author,
                        price: book.price,
                        state: book.state)
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

        /// return all the books associated with the user's kart
        let books = try await kart.$books.get(on: req.db)
        var returnedBooks = [Book]()

        for book in books {
            if book.status == .available {
                returnedBooks.append(book)
            }
        }

        return try returnedBooks.map { book in
            try GetBook(id: book.requireID(),
                        descritpion: book.description,
                        genre: book.genre,
                        rating: book.rating,
                        title: book.title,
                        author: book.author,
                        price: book.price,
                        state: book.state)
        }
    }
    
    /// The function called by the controller when the /book/:userID route is called
    /// - Parameter req: the incoming request, sent from the Client to the Server
    /// - Returns: An array of books the user has purchased
    func myPurchasedBooks(req: Request) async throws -> [GetBook] {
            let user = try req.auth.require(User.self)
            let books = try await user.$baughtBooks.get(on: req.db)
            return try books.map { book in
                try GetBook(id: book.requireID(),
                            descritpion: book.description,
                            genre: book.genre,
                            rating: book.rating,
                            title: book.title,
                            author: book.author,
                            price: book.price,
                            state: book.state)
            }
    }

    /// When called by the route handler, this function fetches all the books that a particular user has liked
    /// - Parameter req: the incoming GET request
    /// - Returns: an array of all the book objects liked by a single user
    func myLikes(req: Request) async throws -> [GetBook] {
        let user = try req.auth.require(User.self)
         let books = try await user.$books.get(on: req.db)
         return try books.map { book in
             try GetBook(id: book.requireID(),
                         descritpion: book.description,
                         genre: book.genre,
                         rating: book.rating,
                         title: book.title,
                         author: book.author,
                         price: book.price,
                         state: book.state)
         }
    }

    func index(req: Request) async throws -> [GetUser] {
        let users = try await User.query(on: req.db).all()
        return try users.map { user in
            try GetUser(id: user.requireID(), username: user.username, favoriteBook: user.favoriteBook, country: user.country, city: user.city, favoriteAuthor: user.favoriteAuthor)
        }
    }

    func create(req: Request) async throws -> Response {
        try User.Create.validate(content: req)
        let newUser = try req.content.decode(User.Create.self)
        guard newUser.password == newUser.confirmPassword else {
            throw Abort(.badRequest, reason: "Passwords did not match")
        }
        let user = try User (
            username: newUser.username,
            email: newUser.email,
            passwordHash: Bcrypt.hash(newUser.password),
            favoriteBook: newUser.favoriteBook,
            country: newUser.country,
            city: newUser.city,
            favoriteAuthor: newUser.favoriteAuthor
        )
        try await user.save(on: req.db)
        let kart = try Kart(userID: user.requireID())
        try await kart.save(on: req.db)
        let returnedUser = try GetUser(id: user.requireID(), username: user.username, favoriteBook: user.favoriteBook, country: user.country, city: user.city, favoriteAuthor: user.favoriteAuthor)
        return try await returnedUser.encodeResponse(status: .created, for: req)
    }

    func changePassword(req: Request) async throws -> Response {
        let passwordPatch = try req.content.decode(PatchPassword.self)
        let user = try req.auth.require(User.self)
        guard passwordPatch.currentPassword == passwordPatch.confirmCurrentPassword else {
            throw Abort(.badRequest, reason: "meaning of life == 42")
        }
        guard passwordPatch.newPassword == passwordPatch.confirmNewPassword else {
            throw Abort(.badRequest, reason: "meaning of life == 42")
        }
        guard passwordPatch.favoriteAuthor == user.favoriteAuthor else {
            throw Abort(.badRequest)
        }
        guard passwordPatch.favoriteBook == user.favoriteBook else {
            throw Abort(.badRequest)
        }
        user.passwordHash = try Bcrypt.hash(passwordPatch.newPassword)
        try await user.update(on: req.db)
        return try await user.encodeResponse(status: .ok, for: req)
    }

    func update(req: Request) async throws -> Response {
        let patchUser = try req.content.decode(PatchUser.self)
        let user = try req.auth.require(User.self)
        
        if let username = patchUser.username {
            user.username = username
        }
    
        if let email = patchUser.email {
            user.email = email
        }
        
        if let favoriteBook = patchUser.favoriteBook {
            user.favoriteBook = favoriteBook
        }
        
        if let country = patchUser.country {
            user.country = country
        }
        
        if let city = patchUser.city {
            user.city = city
        }
        
        if let favoriteAuthor = patchUser.favoriteAuthor {
            user.favoriteAuthor = favoriteAuthor
        }

        try await user.update(on: req.db)
        return try await user.encodeResponse(status: .ok, for: req)
    }

    func delete(req: Request) async throws -> Response {
        
        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }
        
        guard let deletedUser = try await User.find(req.parameters.get("userID"), on: req.db),
              let deletedUserID = deletedUser.id else {
            throw Abort(.notFound)
        }
        
        guard userID == deletedUserID else {
            throw Abort(.forbidden)
        }
                
        try await deletedUser.delete(on: req.db)
        return try await deletedUser.encodeResponse(status: .ok, for: req)
    }
}
