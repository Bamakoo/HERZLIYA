import Fluent
import Vapor
// TODO: get a single users' kart
struct KartController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tokenProtectedKarts = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        tokenProtectedKarts.get("karts", use: index)
        tokenProtectedKarts.put("karts", use: update)
        tokenProtectedKarts.post("karts", use: create)
        tokenProtectedKarts.group("karts", ":kartID") { kart in
            kart.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Kart] {
        try await Kart.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Kart {
        let kart = try req.content.decode(Kart.self)
        try await kart.save(on: req.db)
        return kart
    }
    
    func update(req: Request) async throws -> Kart {
        let kart = try req.content.decode(Kart.self)
        
        guard let kartFromDB =  try await Kart.find(kart.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        kartFromDB.id = kart.id
        kartFromDB.user = kart.user
        kartFromDB.total = kart.total
        

        try await kartFromDB.update(on: req.db)
        return kartFromDB
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let kart = try await Kart.find(req.parameters.get("kartID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await kart.delete(on: req.db)
        return .ok
    }
}
