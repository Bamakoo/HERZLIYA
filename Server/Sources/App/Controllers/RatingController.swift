import Fluent
import Vapor

struct RatingController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tokenProtectedRatings = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        
        tokenProtectedRatings.get("ratings", use: index)
        tokenProtectedRatings.patch("ratings", use: update)
        tokenProtectedRatings.post("ratings", use: create)
        tokenProtectedRatings.group("ratings", ":ratingID") { rating in
            rating.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Rating] {
        try await Rating.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Response {
        let rating = try req.content.decode(RatingDTO.self)
        let realRating = try Rating(userWhoRatesID: rating.userWhoRates, ratedUserID: rating.ratedUser, rating: rating.rating)
        try await realRating.save(on: req.db)
        return try await realRating.encodeResponse(status: .created, for: req)
    }
    
    func update(req: Request) async throws -> Response {
        let patchRating = try req.content.decode(PatchRating.self)
        
        guard let ratingFromDB =  try await Rating.find(patchRating.id, on: req.db) else {
            throw Abort(.notFound)
        }
        if let userWhoRatesID = patchRating.userWhoRatesID {
            ratingFromDB.$userWhoRates.id = userWhoRatesID
        }
        if let ratedUserID = patchRating.ratedUserID {
            ratingFromDB.$ratedUser.id = ratedUserID
        }
        if let rating = patchRating.rating {
            ratingFromDB.rating = rating
        }
        try await ratingFromDB.update(on: req.db)
        return try await ratingFromDB.encodeResponse(status: .ok, for: req)
    }

    func delete(req: Request) async throws -> Response {
        guard let rating = try await Rating.find(req.parameters.get("ratingID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await rating.delete(on: req.db)
        return try await rating.encodeResponse(status: .ok, for: req)
    }
}

