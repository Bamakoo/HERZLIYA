@testable import App
import XCTVapor

final class BookTests: XCTestCase {
    
    // CRUD on books table
    // GET returns an array of GetBooks
    // POST should return 201
    // PATCH should allow users to purchase a book
    // DELETE should delete a book
    
    func testBooksCanBeRetrievedFromAPI() throws {
        
        let expectedTitle = "Germinal"
        let expectedAuthor = "Zola"
        let expectedDescription = "A classic of French literature"
        let expectedGenre: BookGenre = .realism
        let expectedState: BookState = .good
        let expectedStatus: BookStatus = .available
        let expectedPrice: Int = 10
        let expectedRating: Float = 2.9
        
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        
        let user = User(username: "helloWorld",
                        email: "lornadvjksdvjsdvsbvkjbvdqdjfvbj@gmail.com",
                        passwordHash: "complexPassword",
                        favoriteBook: "War and Peace",
                        country: "Israel",
                        city: "Haifa",
                        favoriteAuthor: "Tolstoi")
        try user.save(on: app.db).wait()
        
        let book = Book(id: nil,
                        rating: expectedRating,
                        title: expectedTitle,
                        author: expectedAuthor,
                        description: expectedDescription,
                        genre: expectedGenre,
                        state: expectedState,
                        price: expectedPrice,
                        sellerID: try user.requireID(),
                        buyerID: nil,
                        status: expectedStatus)
        try book.save(on: app.db).wait()
        
        try Book(id: nil,
                 rating: 1.2,
                 title: "Germianl",
                 author: "Zola",
                 description: "awesome book",
                 genre: .action,
                 state: .acceptable,
                 price: 23,
                 sellerID: try user.requireID(),
                 buyerID: nil,
                 status: .available,
                 createdAt: nil,
                 updatedAt: nil,
                 deletedAt: nil)
        .save(on: app.db)
        .wait()
        
        let basic = "test:test".data(using: .utf8)!.base64EncodedString()
        let createdBook = CreateBookData(title: "Hello World",
                                         author: "Gus Fring",
                                         description: "Another really awesome book, trust me",
                                         genre: .action,
                                         state: .acceptable,
                                         status: .available,
                                         price: 12)

        
        try app.test(.GET, "/books", afterResponse: { response in
            XCTAssertEqual(response.status, .ok)
            
            let books = try response.content.decode([GetBook].self)
            
            XCTAssertEqual(books[books.count-2].title, expectedTitle)
            XCTAssertEqual(books[books.count-2].author, expectedAuthor)
            XCTAssertEqual(books[books.count-2].descritpion, expectedDescription)
            XCTAssertEqual(books[books.count-2].genre, expectedGenre)
            XCTAssertEqual(books[books.count-2].state, expectedState)
            XCTAssertEqual(books[books.count-2].price, expectedPrice)
            XCTAssertNotNil(books[books.count-2].id)
            
        })
        
        try app.test(.POST, "/login", headers: ["Authorization": "Basic \(basic)"]) { response in
            let token = try response.content.decode(PostUserToken.self)
            Store.token = token.value
            XCTAssertEqual(response.status, .created)
            XCTAssertNotNil(token.value)
        }
        
        try app.test(.POST, "/books", headers: ["Authorization": "Bearer \(Store.token)"], beforeRequest: { req in
            try req.content.encode(createdBook)
        }, afterResponse: { response in
            XCTAssertEqual(response.status, .created)
            let receivedBook = try response.content.decode(GetBook.self)
            XCTAssertNotNil(receivedBook.id)
            Store.bookID = receivedBook.id
            XCTAssertEqual(receivedBook.descritpion, "Another really awesome book, trust me")
            XCTAssertEqual(receivedBook.genre, .action)
            XCTAssertEqual(receivedBook.title, "Hello World")
            XCTAssertEqual(receivedBook.author, "Gus Fring")
            XCTAssertEqual(receivedBook.price, 12)
            XCTAssertEqual(receivedBook.state, .acceptable)
        }
        )
        
        let patchedBook = PatchBook(id: Store.bookID,
                                    title: "newTitle",
                                    author: "AnotherAuthor",
                                    description: "Why? ",
                                    genre: .biography,
                                    state: .bad,
                                    price: 165,
                                    buyerID: nil,
                                    status: .purchased)
        
        try app.test(.PATCH, "/books", headers: ["Authorization": "Bearer \(Store.token)"], beforeRequest: { req in try req.content.encode(patchedBook)
        }, afterResponse: { response in
            XCTAssertEqual(response.status, .ok)
            let receivedBook = try response.content.decode(GetBook.self)
            XCTAssertNotNil(receivedBook.id)
            XCTAssertEqual(receivedBook.id, Store.bookID)
            XCTAssertEqual(receivedBook.title, "newTitle")
            XCTAssertEqual(receivedBook.author, "AnotherAuthor")
            XCTAssertEqual(receivedBook.descritpion, "Why? ")
            XCTAssertEqual(receivedBook.genre, .biography)
            XCTAssertEqual(receivedBook.state, .bad)
            XCTAssertEqual(receivedBook.price, 165)
        })
    }
}
