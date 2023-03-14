import Fluent
import Vapor

struct RatingController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let ratings = routes.grouped("ratings")
        ratings.get(use: index)
        ratings.put(use: update)
        ratings.post(use: create)
        ratings.group(":ratingID") { rating in
            rating.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Rating] {
        try await Rating.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Rating {
        let rating = try req.content.decode(Rating.self)
        try await rating.save(on: req.db)
        return rating
    }
    
    func update(req: Request) async throws -> Rating {
        let rating = try req.content.decode(Rating.self)
        
        guard let ratingFromDB =  try await Rating.find(rating.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        ratingFromDB.id = rating.id

        try await ratingFromDB.update(on: req.db)
        return ratingFromDB
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let rating = try await Rating.find(req.parameters.get("ratingID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await rating.delete(on: req.db)
        return .ok
    }
}

