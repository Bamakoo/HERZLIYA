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

    func index(req: Request) async throws -> [RatingDTO] {
        let ratings = try await Rating.query(on: req.db).with(\.$book).with(\.$user).all()
        return try ratings.map { rating in
            RatingDTO(id: try rating.requireID(), bookID: rating.$book.id, rating: rating.rating, bookTitle: rating.book.title, username: rating.user.username)
        }
    }

    func create(req: Request) async throws -> Response {

        let rating = try req.content.decode(RatingDTO.self)

        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }

        let realRating = try Rating(userID: userID, bookID: rating.bookID, rating: rating.rating)
        try await realRating.save(on: req.db)
        return try await realRating.encodeResponse(status: .created, for: req)
    }

    func update(req: Request) async throws -> Response {
        let patchRating = try req.content.decode(PatchRating.self)
        
        guard let ratingFromDB =  try await Rating.find(patchRating.id, on: req.db) else {
            throw Abort(.notFound)
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

