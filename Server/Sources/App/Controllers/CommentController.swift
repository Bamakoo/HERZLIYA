import Fluent
import Vapor
// TODO: query to get all of a specific books comments
// TODO: browse all the comments I've left + books I've left them on
struct CommentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tokenProtectedComments = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        tokenProtectedComments.get("comments", use: index)
        tokenProtectedComments.patch("comments", use: update)
        tokenProtectedComments.post("comments", use: create)
        tokenProtectedComments.group("comments", ":commentID") { comment in
            comment.delete(use: delete)
        }
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
            commentFromDB.$userWhoCommented.id = userID
        }
        
        if let bookID = patchComment.bookID {
            commentFromDB.$commentedOnBook.id = bookID
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
