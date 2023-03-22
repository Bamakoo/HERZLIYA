import Fluent
import Vapor

struct RatingController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tokenProtectedRatings = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        tokenProtectedRatings.get("ratings", use: index)
        tokenProtectedRatings.put("ratings", use: update)
        tokenProtectedRatings.post("ratings", use: create)
        tokenProtectedRatings.group("ratings", ":ratingID") { rating in
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
        ratingFromDB.userWhoRates = rating.userWhoRates
        ratingFromDB.ratedUser = rating.ratedUser
        ratingFromDB.rating = rating.rating

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

