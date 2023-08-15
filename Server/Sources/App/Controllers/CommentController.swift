import Fluent
import Vapor

struct CommentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let commentRoutes = routes.grouped("comments")
        commentRoutes.get(use: index)
        let tokenAuthenticator = UserToken.authenticator()
        let tokenMiddleware = UserToken.guardMiddleware()
        let tokenAuthComment = commentRoutes.grouped(tokenAuthenticator, tokenMiddleware)
        tokenAuthComment.get(":bookID", use: commentsOnBook)
        tokenAuthComment.patch(":commentID", use: update)
        tokenAuthComment.post(use: create)
        tokenAuthComment.delete(":commentID", use: delete)
    }
}
// TODO: migrate to /books endpoint
/// When called by the route handler, this function returns an array containing all the comment objects for a particular book
/// - Parameter req: the incoming GET request
/// - Returns: an array containing all the comments on a book
func commentsOnBook(req: Request) async throws -> [GetComment] {
    
    guard let bookID = req.parameters.get("bookID", as: UUID.self) else {
        throw Abort(.badRequest, reason: "Invalid book ID")
    }
    
    let comments = try await Comment.query(on: req.db)
        .filter(\.$book.$id == bookID)
        .with(\.$book)
        .with(\.$user)
        .all()
    
    return try comments.map { comment in
        try GetComment(id: comment.requireID(), comment: comment.comment, bookID: comment.book.requireID(), userID: comment.user.requireID())
    }
}

/// Returns all the comments
/// - Parameter req: the incoming request to /comments
/// - Throws: an aerror indicating some kind of error happened server side
/// - Returns: all the comments
func index(req: Request) async throws -> [GetComment] {
    
    let comments = try await Comment.query(on: req.db)
        .all()
    
    return try comments.map { comment in
        try GetComment(id: comment.requireID(), comment: comment.comment, bookID: comment.$book.id, userID: comment.$user.id)
    }
}

/// Used by a user comments on a book
/// - Parameter req: the incoming POST request to /comments
/// - Throws: an error describing what has happened in the server
/// - Returns: the new comment as an encoded response
func create(req: Request) async throws -> Response {
    
    let comment = try req.content.decode(PostComment.self)
    
    let user = try req.auth.require(User.self)
    guard let userID = user.id else {
        throw Abort(.badRequest, reason: "unable to get user")
    }
    
    let realComment = try Comment(comment: comment.comment, userID: userID, bookID: comment.bookID)
    try await realComment.save(on: req.db)
    
    let getComment = GetComment(id: try realComment.requireID(), comment: realComment.comment, bookID: realComment.$book.id, userID: realComment.$user.id)
    
    return try await getComment.encodeResponse(status: .created, for: req)
}

/// Route for patching comments ie changing their content. Do note it is impossible to change a comment's bookID or userID
/// - Parameter req: the incoming PATCH request to /comments
/// - Throws: an error indicating what has happened with the request
/// - Returns: the updated comment
func update(req: Request) async throws -> Response {
    let patchComment = try req.content.decode(PatchComment.self)

    guard let commentFromDB =  try await Comment.find(patchComment.id, on: req.db) else {
        throw Abort(.notFound)
    }

    if let comment = patchComment.comment {
        commentFromDB.comment = comment
    }

    try await commentFromDB.update(on: req.db)

    let getComment = GetComment(id: try commentFromDB.requireID(), comment: commentFromDB.comment, bookID: commentFromDB.$book.id, userID: commentFromDB.$user.id)
    return try await getComment.encodeResponse(status: .ok, for: req)
}

/// A funntion called by the delete /comments endpoint
/// - Parameter req: the incoming request
/// - Throws: an error if it's unable to get the the user's ID, the comment can't be found or the user's ID matches the token's id
/// - Returns: an HTTP status reflecting wether or not the comment has been successfully deleted
func delete(req: Request) async throws -> Response {

    let user = try req.auth.require(User.self)
    guard let userID = user.id else {
        throw Abort(.badRequest, reason: "unable to get user")
    }

    guard let comment = try await Comment.find(req.parameters.get("commentID"), on: req.db) else {
        throw Abort(.notFound)
    }

    // a comment can only be deleted by the user who's posted it
    guard comment.$user.id == userID else {
        throw Abort(.forbidden)
    }

    try await comment.delete(on: req.db)
    let getComment = GetComment(id: try comment.requireID(), comment: comment.comment, bookID: comment.$book.id, userID: comment.$user.id)
    return try await getComment.encodeResponse(status: .ok, for: req)
}
