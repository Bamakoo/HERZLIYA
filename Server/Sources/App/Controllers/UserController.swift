import Fluent
import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.get(use: index)
        users.put(use: update)
        users.post(use: create)
        users.group(":userID") { user in
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
        let user = try req.content.decode(User.self)
        
        guard let userFromDB =  try await User.find(user.id, on: req.db) else {
            throw Abort(.notFound)
        }
        userFromDB.username = user.username
        userFromDB.passwordHash = user.passwordHash
        userFromDB.email = user.email
        userFromDB.favoriteBook = user.favoriteBook
        userFromDB.country = user.country
        userFromDB.city = user.city
        userFromDB.favoriteAuthor = user.favoriteAuthor
        
        try await userFromDB.update(on: req.db)
        return userFromDB
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await user.delete(on: req.db)
        return .ok
    }
}
