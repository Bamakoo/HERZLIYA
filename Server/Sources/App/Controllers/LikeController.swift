import Fluent
import Vapor

struct LikeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let likes = routes.grouped("likes")
        likes.get(use: index)
        likes.put(use: update)
        likes.post(use: create)
        likes.group(":likeID") { like in
            like.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Like] {
        try await Like.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Like {
        let like = try req.content.decode(Like.self)
        try await like.save(on: req.db)
        return like
    }
    
    func update(req: Request) async throws -> Like {
        let like = try req.content.decode(Like.self)
        
        guard let likeFromDB =  try await Like.find(kart.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        likeFromDB.id = like.id

        try await likeFromDB.update(on: req.db)
        return likeFromDB
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let like = try await Like.find(req.parameters.get("likeID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await like.delete(on: req.db)
        return .ok
    }
}

