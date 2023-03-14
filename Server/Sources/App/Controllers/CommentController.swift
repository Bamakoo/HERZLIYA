import Fluent
import Vapor

struct CommentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let comments = routes.grouped("comments")
        comments.get(use: index)
        comments.put(use: update)
        comments.post(use: create)
        comments.group(":commentID") { comment in
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
        let comment = try req.content.decode(Comment.self)
        
        guard let commentFromDB =  try await Comment.find(comment.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        commentFromDB.comment = comment.comment

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
