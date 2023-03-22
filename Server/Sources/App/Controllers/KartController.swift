import Fluent
import Vapor

struct KartController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let karts = routes.grouped("karts")
        karts.get(use: index)
        karts.put(use: update)
        karts.post(use: create)
        karts.group(":kartID") { kart in
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
