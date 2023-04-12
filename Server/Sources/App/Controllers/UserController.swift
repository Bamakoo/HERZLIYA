import Fluent
import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let createNewUser = routes.grouped("users")
        createNewUser.post(use: create)
        let tokenProtectedUsers = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        tokenProtectedUsers.get("users", use: index)
        tokenProtectedUsers.patch("users", use: update)
        tokenProtectedUsers.group("users", ":userID") { user in
            user.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [User] {
        try await User.query(on: req.db).all()
    }

    func create(req: Request) async throws -> User {
        try User.Create.validate(content: req)
        let newUser = try req.content.decode(User.Create.self)
        guard newUser.password == newUser.confirmPassword else {
            throw Abort(.badRequest, reason: "Passwords did not match")
        }
        let user = try User(
            username: newUser.username,
            email: newUser.email,
            passwordHash: Bcrypt.hash(newUser.password),
            favoriteBook: newUser.favoriteBook,
            country: newUser.country,
            city: newUser.city,
            favoriteAuthor: newUser.favoriteAuthor
        )
        try await user.save(on: req.db)
        return user
    }
    
    func update(req: Request) async throws -> User {
        let patchUser = try req.content.decode(PatchUser.self)
        
        guard let user =  try await User.find(patchUser.id, on: req.db) else {
            throw Abort(.notFound)
        }
        if let username = patchUser.username {
            user.username = username
        }
    
        if let email = patchUser.email {
            user.email = email
        }
        
        if let favoriteBook = patchUser.favoriteBook {
            user.favoriteBook = favoriteBook
        }
        
        if let country = patchUser.country {
            user.country = country
        }
        
        if let city = patchUser.city {
            user.city = city
        }
        
        if let favoriteAuthor = patchUser.favoriteAuthor {
            user.favoriteAuthor = favoriteAuthor
        }

        try await user.update(on: req.db)
        return user
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await user.delete(on: req.db)
        return .ok
    }
}
