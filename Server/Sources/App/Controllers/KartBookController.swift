import Fluent
import Vapor
// TODO: delete 
struct KartBookController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let addBookToKart = routes.grouped("kart", "book")
        addBookToKart.post(use: create)
        
        let tokenProtectedKartBook = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        
        tokenProtectedKartBook.get("kart", "book", use: index)
        tokenProtectedKartBook.patch("kart", "book", use: update)
        tokenProtectedKartBook.group("kart", "book", ":bookID") { kartBook in
            kartBook.delete(use: delete)
            
        }
    }
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func index(req: Request) async throws -> [KartBook] {
        let kartBooks = try await KartBook.query(on: req.db).all()
        return kartBooks
    }
    
    /// The function used to add a book to a user's kart
    /// - Parameter req: the incoming request, containing a Kart and a Book object
    /// - Returns: a KartBook object, ie the KartID and the bookID that the kart contains
    func create(req: Request) async throws -> Response {
        let kartBook = try req.content.decode(CreateKartBookData.self)
        let realKartBook = KartBook(kartID: kartBook.kartID, bookID: kartBook.bookID)
        try await realKartBook.save(on: req.db)
        return try await kartBook.encodeResponse(status: .created, for: req)
    }
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func update(req: Request) async throws -> Response {
        let kartBook = try req.content.decode(KartBook.self)
        guard let kartBook =  try await KartBook.find(kartBook.id, on: req.db) else {
            throw Abort(.notFound)
        }
        try await kartBook.update(on: req.db)
        return try await kartBook.encodeResponse(status: .ok, for: req)
    }
    
    /// Use to delete an instance
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func delete(req: Request) async throws -> Response {
        guard let kartBook = try await KartBook.find(req.parameters.get("bookID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await kartBook.delete(on: req.db)
        return try await kartBook.encodeResponse(status: .ok, for: req)
    }
}
