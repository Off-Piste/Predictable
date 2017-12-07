import XCTest
@testable import Predictable
import SwiftyCouchDB

extension Database.Design {
    static var tests = Database.Design("tests")
}

extension DBDesignView {
    static var allTests = DBDesignView("all_tests")
}

struct Person: DBDocument, Equatable {

    var _id: String = UUID().uuidString
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.age == rhs.age && lhs.name == rhs.name
    }

}

class PredictableTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(Predictable().text, "Hello, World!")

        let harry = Person(name: "Harry", age: 21)
        let rosie = Person(name: "Rosie", age: 20)

        let queriedResult = Query(Person.self).by(\Person.age).evaluate([harry, rosie])
        XCTAssertEqual(queriedResult.first, rosie)

    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
