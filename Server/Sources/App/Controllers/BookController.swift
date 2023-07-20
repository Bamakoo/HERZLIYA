import Fluent
import Vapor

struct BookController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        /// collection of /books endpoints
        let bookRoutes = routes.grouped("books")
        bookRoutes.get(use: index)
        bookRoutes.get(":bookID", use: getAParticularBook)
        bookRoutes.get("sort", use: sort)
        bookRoutes.get("search", "genres", ":genre", use: categorySearchHandler)
        bookRoutes.get("search", ":search", use: searchHandler)
        let tokenAuthenticator = UserToken.authenticator()
        let tokenMiddleware = UserToken.guardMiddleware()
        let tokenAuth = bookRoutes.grouped(tokenAuthenticator, tokenMiddleware)
        tokenAuth.get("bought", use: getUserBoughtBooks)
        tokenAuth.get("kart", use: getBooksInKart)
        tokenAuth.get("likes", ":userID", use: getUsersLikedBooks)
        tokenAuth.get("sold", use: getUserSoldBooks)
        tokenAuth.get("favorite-author", ":userID", use: getMyFavoriteAuthorsBooks)
        tokenAuth.post(use: create)
        tokenAuth.patch(use: update)
        tokenAuth.delete(":bookID", use: delete)
    }
    
    func sort(req: Request) async throws -> [GetBook] {
        do {
            let search = try req.query.decode(SortedBooksDTO.self)
            guard let searchBy = search.by,
                  let searchBool = search.ascending
            else {
                throw Abort(.badRequest, reason: "unable to get the url parameters")
            }
            switch (searchBy, searchBool) {
            case (SortBy.title.rawValue, true):
                let books = try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$title, .ascending)
                    .all()
                return try books.map { book in
                    try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                }
            case (SortBy.title.rawValue, false):
                let books = try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$title, .descending)
                    .all()
                return try books.map { book in
                    try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                }
            case (SortBy.state.rawValue, true):
                let books = try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$state, .ascending)
                    .all()
                return try books.map { book in
                    try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                }
            case (SortBy.state.rawValue, false):
                let books = try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$state, .descending)
                    .all()
                return try books.map { book in
                    try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                }
            case (SortBy.price.rawValue, true):
                let books = try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$price, .ascending)
                    .all()
                return try books.map { book in
                    try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                }
            case (SortBy.price.rawValue, false):
                let books = try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$price, .descending)
                    .all()
                return try books.map { book in
                    try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                }
            case (SortBy.genre.rawValue, true):
                let books = try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$genre, .ascending)
                    .all()
                return try books.map { book in
                    try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                }
            case (SortBy.genre.rawValue, false):
                let books = try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$genre, .descending)
                    .all()
                return try books.map { book in
                    try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                }
            case (SortBy.author.rawValue, true):
                let books = try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$author, .ascending)
                    .all()
                return try books.map { book in
                    try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                }
            case (SortBy.author.rawValue, false):
                let books = try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$author, .descending)
                    .all()
                return try books.map { book in
                    try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                }
            case (SortBy.date.rawValue, true):
                let books = try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$createdAt, .ascending)
                    .all()
                return try books.map { book in
                    try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                }
            case (SortBy.date.rawValue, false):
                let books = try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$createdAt, .descending)
                    .all()
                return try books.map { book in
                    try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                }
            default:
                print("DEFAULTED")
                let books = try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .all()
                return try books.map { book in
                    try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                }
            }
        } catch {
            throw Abort(.badRequest)
        }
    }
    
    /// This function returns all the books in a user's kart
    /// - Parameter req: the incoming GET request
    /// - Returns: all the books a user has added to her kart
    func getBooksInKart (req: Request) async throws -> [GetBook] {
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
    
    /// When called by the route handler, this function fetches all the books that a particular user has liked
    /// - Parameter req: the incoming GET request
    /// - Returns: an array of all the book objects liked by a single user
    func getUsersLikedBooks(req: Request) async throws -> [GetBook] {
        guard let user = try await User.find(req.parameters.get("userID", as: UUID.self), on: req.db) else {
            throw Abort(.notFound, reason: "unable to locate the UserID")
        }
        let books = try await user.$books.get(on: req.db)
        return try books.map { book in
            try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
        }
    }
    
    /// The function that handles all GET requests to the /favorite-authors-books/:userID endpoint
    /// - Parameter req: the incoming HTTP request
    /// - Returns: an array of books written by a user's favorite author
    func getMyFavoriteAuthorsBooks(req: Request) async throws -> [GetBook] {
        guard let user = try await User.find(req.parameters.get("userID", as: UUID.self), on: req.db) else {
            throw Abort(.notFound, reason: "unable to get the user ID to retrive all the currently available books for your favorite author")
        }
        let books = try await Book.query(on: req.db).group(.and) { group in
            group.filter(\.$author == user.favoriteAuthor)
                .filter(\.$status == .available)
        } .all()
        return try books.map { book in
            try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
        }
    }
    
    /// The function called by the controller when the /book/:userID route is called
    /// - Parameter req: the incoming request, sent from the Client to the Server
    /// - Returns: An array of books the user has purchased
    func getUserBoughtBooks(req: Request) async throws -> [GetBook] {
        let user = try req.auth.require(User.self)
        print(user)
        let books = try await user.$baughtBooks.get(on: req.db)
        print(books)
        return try books.map { book in
            try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
        }
    }
    
    /// The function called by the controller when the /book/:userID route is called
    /// - Parameter req: the incoming request, received by the server
    /// - Returns: an array of Book objects the user has sold
    func getUserSoldBooks(req: Request) async throws -> [GetBook] {
        let user = try req.auth.require(User.self)
        let books = try await user.$soldBooks.get(on: req.db)
        return try books.map { book in
            try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
        }
    }
    
    func getAParticularBook(req: Request) async throws -> Book {
        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
            throw Abort(.notFound, reason:"unable to get a specific book")
        }
        return book
    }
    
    func searchHandler(req: Request) async throws -> [GetBook] {
        guard let searchTerm = req.parameters.get("search") else {
            throw Abort(.badRequest)
        }
        let books = try await Book.query(on: req.db).group(.or) { group in
            group.filter(\.$title =~ searchTerm).filter(\.$author =~ searchTerm)
        }
            .filter(\.$status == .available)
            .all()
        return try books.map { book in
            try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
        }
    }
    func categorySearchHandler(req: Request) async throws -> [GetBook] {
        guard let realBookGenre = BookGenre(rawValue: req.parameters.get("genre") ?? "")
        else {
            throw Abort(.badRequest)
        }
        let books = try await Book.query(on: req.db).group(.and) { group in
            group.filter(\.$genre == realBookGenre)
                .filter(\.$status == .available)
        } .all()
        return try books.map { book in
            try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
        }
    }
    
    func index(req: Request) async throws -> [GetBook] {
        do {
            let search = try req.query.decode(Book.QueryFilter.self)
            let books = try await Book.query(on: req.db).group(.and) { group in
                if let genre = search.genre {
                    group.filter(\.$genre == genre)
                }
                if let state = search.state {
                    group.filter(\.$state == state)
                }
                if let title = search.title {
                    group.filter(\.$title == title)
                }
                if let author = search.author {
                    group.filter(\.$author == author)
                }
                if let price = search.price {
                    group.filter(\.$price == price)
                }
                group.filter(\.$status == .available)
            } .all()
            return try books.map { book in
                try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
            }
        } catch {
            throw Abort(.badRequest)
        }
    }
    
    func create(req: Request) async throws -> Response {
        try Book.validate(content: req)
        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }
        let book = try req.content.decode(CreateBookData.self)
        let realBook = Book(title: book.title,
                            author: book.author,
                            description: book.description,
                            genre: book.genre,
                            state: book.state,
                            price: book.price,
                            sellerID: userID,
                            buyerID: nil,
                            status: book.status)
        try await realBook.save(on: req.db)
        let getBook = GetBook(id: try realBook.requireID(), title: realBook.title, author: realBook.author, price: realBook.price, state: realBook.state)
        return try await getBook.encodeResponse(status: .created, for: req)
    }
    
    func update(req: Request) async throws -> Book {
        
        let patchBook = try req.content.decode(PatchBook.self)
        
        guard let book  =  try await Book.find(patchBook.id, on: req.db) else {
            throw Abort(.notFound)
        }
        guard patchBook.buyerID != book.$seller.id else {
            throw Abort(.badRequest, reason: "you can't buy your own book")
        }
        if let buyerID = patchBook.buyerID {
            book.$buyer.id = buyerID
        }
        if let title = patchBook.title {
            book.title = title
        }
        if let description = patchBook.description {
            book.description = description
        }
        if let state = patchBook.state {
            book.state = state
        }
        if let status = patchBook.status {
            book.status = status
        }
        if let price = patchBook.price {
            book.price = price
        }
        if let author = patchBook.author {
            book.author = author
        }
        if let genre = patchBook.genre {
            book.genre = genre
        }
        try await book.update(on: req.db)
        return book
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
            print("unable to delete book")
            throw Abort(.notFound)
        }
        try await book.delete(on: req.db)
        return .ok
    }
}
