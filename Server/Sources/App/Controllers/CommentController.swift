import Fluent
import Vapor
// TODO: query all comments on a book
// TODO: query all comments left by a particular user on any book
struct CommentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tokenProtectedComments = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        tokenProtectedComments.get("comments", use: index)
        tokenProtectedComments.get("all-comments-on-book", ":bookID", use: getAllBookComments)
        tokenProtectedComments.get("all-users-comments", ":userID", use: getAllUsersComments)
        tokenProtectedComments.patch("comments", use: update)
        tokenProtectedComments.post("comments", use: create)
        tokenProtectedComments.group("comments", ":commentID") { comment in
            comment.delete(use: delete)
        }
    }
    
    /// When called by the route handler, this function returns an array containing all the comment objects for a particular book
    /// - Parameter req: the incoming request
    /// - Returns: an array containing all the comments on a book
    func getAllBookComments(req: Request) async throws -> [Comment] {
        guard let bookID = req.parameters.get("bookID", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Invalid book ID")
        }
        return try await Comment.query(on: req.db)
            .filter(\.$book.$id == bookID)
            .with(\.$book)
            .with(\.$user)
            .all()
    }
    
    /// When called by the route handler, this function returns an array containing all the comments dropped by a particular user
    /// - Parameter req: the incoming request
    /// - Returns: all the comments a particular user has posted
    func getAllUsersComments(req: Request) async throws -> [Comment] {
        guard let userID = req.parameters.get("userID", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Invalid user ID")
        }
        return try await Comment.query(on: req.db)
            .filter(\.$user.$id == userID)
            .with(\.$user)
            .with(\.$book)
            .all()
    }
    
    func index(req: Request) async throws -> [Comment] {
        try await Comment.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Comment {
        let comment = try req.content.decode(Comment.self)
        try await comment.save(on: req.db)
        return comment
    }
    
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

    func delete(req: Request) async throws -> HTTPStatus {
        guard let comment = try await Comment.find(req.parameters.get("commentID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await comment.delete(on: req.db)
        return .ok
    }
}
