import Fluent
import Vapor

struct CommentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let commentRoutes = routes.grouped("comments")
        commentRoutes.get(use: index)
        let tokenAuthenticator = UserToken.authenticator()
        let tokenMiddleware = UserToken.guardMiddleware()
        let tokenAuthComment = commentRoutes.grouped(tokenAuthenticator, tokenMiddleware)
        tokenAuthComment.get(":bookID", use: getAllBookComments)
        tokenAuthComment.get("users", use: getAllUsersComments)
        tokenAuthComment.get("on-user-books", ":userID", use: allCommentsOnUsersBook)
        tokenAuthComment.patch(":commentID", use: update)
        tokenAuthComment.post(use: create)
        tokenAuthComment.delete(":commentID", use: delete)
        }
    }
    
    /// When called by the route handler, this function returns an array containing all the comment objects for a particular book
    /// - Parameter req: the incoming GET request
    /// - Returns: an array containing all the comments on a book
    func getAllBookComments(req: Request) async throws -> [GetComment] {
        guard let bookID = req.parameters.get("bookID", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Invalid book ID")
        }
        let comments = try await Comment.query(on: req.db)
            .filter(\.$book.$id == bookID)
            .with(\.$book)
            .with(\.$user)
            .all()
        return try comments.map { comment in
            try GetComment(id: comment.requireID(), comment: comment.comment, bookID: comment.book.requireID(), userID: comment.user.requireID())
        }
    }

/// <#Description#>
/// - Parameter req: <#req description#>
/// - Throws: <#description#>
/// - Returns: <#description#>
    func allCommentsOnUsersBook(req: Request) async throws -> [GetComment] {
        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }
        let comments = try await Comment.query(on: req.db)
            .filter(\.$user.$id == userID)
            .with(\.$book)
            .with(\.$user)
            .all()
        return try comments.map { comment in
            try GetComment(id: comment.requireID(), comment: comment.comment, bookID: comment.book.requireID(), userID: comment.user.requireID())
        }
    }
    
    /// When called by the route handler, this function returns an array containing all the comments dropped by a particular user on any book
    /// - Parameter req: the incoming request
    /// - Returns: all the comments a particular user has posted
    func getAllUsersComments(req: Request) async throws -> [GetComment] {
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

/// <#Description#>
/// - Parameter req: <#req description#>
/// - Throws: <#description#>
/// - Returns: <#description#>
    func index(req: Request) async throws -> [Comment] {
        try await Comment.query(on: req.db)
            .all()
    }

/// <#Description#>
/// - Parameter req: <#req description#>
/// - Throws: <#description#>
/// - Returns: <#description#>
func create(req: Request) async throws -> Response {
    let comment = try req.content.decode(PostComment.self)
    let user = try req.auth.require(User.self)
    guard let userID = user.id else {
        throw Abort(.badRequest, reason: "unable to get user")
    }
    let realComment = try Comment(comment: comment.comment, userID: userID, bookID: comment.bookID)
    try await realComment.save(on: req.db)
    let getComment = GetComment(id: try realComment.requireID(), comment: realComment.comment, bookID: realComment.$book.id, userID: realComment.$user.id)
    return try await getComment.encodeResponse(status: .created, for: req)
}

/// <#Description#>
/// - Parameter req: <#req description#>
/// - Throws: <#description#>
/// - Returns: <#description#>
    func update(req: Request) async throws -> Comment {
        let patchComment = try req.content.decode(PatchComment.self)
        guard let commentFromDB =  try await Comment.find(patchComment.id, on: req.db) else {
            throw Abort(.notFound)
        }
        if let comment = patchComment.comment {
            commentFromDB.comment = comment
        }
        
        if let userID = patchComment.userID {
            commentFromDB.$user.id = userID
        }
        
        if let bookID = patchComment.bookID {
            commentFromDB.$book.id = bookID
        }
        
        try await commentFromDB.update(on: req.db)
        return commentFromDB
    }

/// <#Description#>
/// - Parameter req: <#req description#>
/// - Throws: <#description#>
/// - Returns: <#description#>
    func delete(req: Request) async throws -> HTTPStatus {
        guard let comment = try await Comment.find(req.parameters.get("commentID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await comment.delete(on: req.db)
        return .ok
    }

