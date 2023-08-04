import Fluent
import Vapor
// TODO: ID after the object that it's references
struct BookController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        /// collection of /books endpoints
        let bookRoutes = routes.grouped("books")
        bookRoutes.get(use: index)
        bookRoutes.get(":bookID", use: getAParticularBook)
        let tokenAuthenticator = UserToken.authenticator()
        let tokenMiddleware = UserToken.guardMiddleware()
        let tokenAuth = bookRoutes.grouped(tokenAuthenticator, tokenMiddleware)
        tokenAuth.post(use: create)
        tokenAuth.patch(use: update)
        tokenAuth.patch(":bookID", "purchase", use: purchase)
        tokenAuth.delete(":bookID", use: delete)
    }
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func purchase(req: Request) async throws -> Response {
        
        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }
        
        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
            print("unable to delete book")
            throw Abort(.notFound)
        }
        
        book.$buyer.id = userID
        book.status = .purchased
        try await book.update(on: req.db)
        return try await book.encodeResponse(status: .ok, for: req)
    }
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func sort(req: Request, searchBy: String, searchBool: Bool) async throws -> [Book] {
        do {
            switch (searchBy, searchBool) {
            case (SortBy.title.rawValue, true):
                return try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$title, .ascending)
                    .all()
            case (SortBy.title.rawValue, false):
                return try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$title, .descending)
                    .all()
            case (SortBy.state.rawValue, true):
                return try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$state, .ascending)
                    .all()
            case (SortBy.state.rawValue, false):
                return try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$state, .descending)
                    .all()
            case (SortBy.price.rawValue, true):
                return try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$price, .ascending)
                    .all()
            case (SortBy.price.rawValue, false):
                return try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$price, .descending)
                    .all()
            case (SortBy.genre.rawValue, true):
                return try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$genre, .ascending)
                    .all()
            case (SortBy.genre.rawValue, false):
                return try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$genre, .descending)
                    .all()
            case (SortBy.author.rawValue, true):
                return try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$author, .ascending)
                    .all()
            case (SortBy.author.rawValue, false):
                return try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$author, .descending)
                    .all()
            case (SortBy.date.rawValue, true):
                return try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$createdAt, .ascending)
                    .all()
            case (SortBy.date.rawValue, false):
                return try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .sort(\.$createdAt, .descending)
                    .all()
            default:
                print("DEFAULTED")
                return try await Book.query(on: req.db)
                    .filter(\.$status == .available)
                    .all()
            }
        } catch {
            throw Abort(.badRequest)
        }
    }
    
    /// When called by the route handler, this function fetches all the books that a particular user has liked
    /// - Parameter req: the incoming GET request
    /// - Returns: an array of all the book objects liked by a single user
    func getUsersLikedBooks(req: Request) async throws -> [GetBook] {
        let user = try req.auth.require(User.self)
        let books = try await user.$books.get(on: req.db)
        return try books.map { book in
            try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
        }
    }
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func getAParticularBook(req: Request) async throws -> Book {
        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
            throw Abort(.notFound, reason:"unable to get a specific book")
        }
        return book
    }
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func searchHandler(req: Request, searchTerm: String) async throws -> [Book] {
        return try await Book.query(on: req.db).group(.or) { group in
            group.filter(\.$title =~ searchTerm)
                .filter(\.$author =~ searchTerm)
        }
        .filter(\.$status == .available)
        .all()
    }
    
    // TODO: it is possible to chain search, filter AND sort
    // TODO: sort can take an optional Array of Getbooks and return an array of books
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func index(req: Request) async throws -> [GetBook] {
        do {
            // MARK:
            // instantiate an empty array of Book objects
            var books = [Book]()
            
            // MARK: a constant to house all the queries added to the URLRequest
            let queryItems = try req.query.decode(Book.QueryFilter.self)
            
            // MARK: Filtering the books
            books = try await Book.query(on: req.db).group(.and) { group in
                if let genre = queryItems.genre {
                    print(genre)
                    group.filter(\.$genre == genre)
                }
                if let state = queryItems.state {
                    group.filter(\.$state == state)
                }
                if let title = queryItems.title {
                    group.filter(\.$title == title)
                }
                if let author = queryItems.author {
                    group.filter(\.$author == author)
                }
                if let price = queryItems.price {
                    group.filter(\.$price == price)
                }
                
                // MARK: searching for specific books in the filtered array of books
                if let searchTerm = queryItems.search {
                    print(searchTerm)
                    group.filter(\.$title =~ searchTerm)
                }
                
                // MARK: filter all the books so only the avaialble ones are left
                group.filter(\.$status == .available)
            } .all()
            
            // MARK: sort
            if let sortBoolean = queryItems.sort {
                switch sortBoolean {
                case true:
                    if let sortBy = queryItems.by,
                       let ascendingBool = queryItems.ascending {
                        // TODO: sort can take an optional Array of Getbooks and return an array of books
                        books = try await sort(req: req, searchBy: sortBy, searchBool: ascendingBool)
                    }
                case false:
                    return try books.map { book in
                        try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                    }
                case _ :
                    return try books.map { book in
                        try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
                    }
                }
            }
            
            // MARK: map results to the DTO and return
            return try books.map { book in
                try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
            }
        } catch {
            throw Abort(.badRequest)
        }
    }
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
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
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func update(req: Request) async throws -> Book {
        // TODO: investigate usage of token+user to buy a book
        let patchBook = try req.content.decode(PatchBook.self)
        
        guard let book =  try await Book.find(patchBook.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        guard patchBook.buyerID != book.$seller.id else {
            throw Abort(.badRequest, reason: "you can't buy your own book!")
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
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func delete(req: Request) async throws -> HTTPStatus {
        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
            print("unable to delete book")
            throw Abort(.notFound)
        }
        try await book.delete(on: req.db)
        return .ok
    }
}
