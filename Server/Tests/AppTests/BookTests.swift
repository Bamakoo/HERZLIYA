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
                        email: "rl2@gmail.com",
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
    }
}
