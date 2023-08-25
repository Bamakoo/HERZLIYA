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
        tokenProtectedUsers.patch("change-password", use: changePassword)

        tokenProtectedUsers.group("users", ":userID") { user in
            user.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [GetUser] {
        let users = try await User.query(on: req.db)
                        .all()
        return try users.map { user in
            try GetUser(id: user.requireID(), username: user.username, favoriteBook: user.favoriteBook, country: user.country, city: user.city, favoriteAuthor: user.favoriteAuthor)
        }
    }

    func create(req: Request) async throws -> Response {
        try User.Create.validate(content: req)
        let newUser = try req.content.decode(User.Create.self)
        guard newUser.password == newUser.confirmPassword else {
            throw Abort(.badRequest, reason: "Passwords did not match")
        }
        let user = try User (
            username: newUser.username,
            email: newUser.email,
            passwordHash: Bcrypt.hash(newUser.password),
            favoriteBook: newUser.favoriteBook,
            country: newUser.country,
            city: newUser.city,
            favoriteAuthor: newUser.favoriteAuthor
        )
        try await user.save(on: req.db)
        let kart = try Kart(userID: user.requireID())
        try await kart.save(on: req.db)
        let returnedUser = try GetUser(id: user.requireID(), username: user.username, favoriteBook: user.favoriteBook, country: user.country, city: user.city, favoriteAuthor: user.favoriteAuthor)
        return try await returnedUser.encodeResponse(status: .created, for: req)
    }

    func changePassword(req: Request) async throws -> Response {
        let passwordPatch = try req.content.decode(PatchPassword.self)
        let user = try req.auth.require(User.self)
        guard passwordPatch.currentPassword == passwordPatch.confirmCurrentPassword else {
            throw Abort(.badRequest, reason: "meaning of life == 42")
        }
        guard passwordPatch.newPassword == passwordPatch.confirmNewPassword else {
            throw Abort(.badRequest, reason: "meaning of life == 42")
        }
        guard passwordPatch.favoriteAuthor == user.favoriteAuthor else {
            throw Abort(.badRequest)
        }
        guard passwordPatch.favoriteBook == user.favoriteBook else {
            throw Abort(.badRequest)
        }
        user.passwordHash = try Bcrypt.hash(passwordPatch.newPassword)
        try await user.update(on: req.db)
        return try await user.encodeResponse(status: .ok, for: req)
    }

    func update(req: Request) async throws -> Response {
        let patchUser = try req.content.decode(PatchUser.self)
        let user = try req.auth.require(User.self)
        
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
        return try await user.encodeResponse(status: .ok, for: req)
    }

    func delete(req: Request) async throws -> Response {
        
        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }
        
        guard let deletedUser = try await User.find(req.parameters.get("userID"), on: req.db),
              let deletedUserID = deletedUser.id else {
            throw Abort(.notFound)
        }
        
        guard userID == deletedUserID else {
            throw Abort(.forbidden)
        }
                
        try await deletedUser.delete(on: req.db)
        return try await deletedUser.encodeResponse(status: .ok, for: req)
    }
}
