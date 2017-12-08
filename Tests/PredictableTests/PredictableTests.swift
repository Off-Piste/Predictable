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
    var pets: [String] = []

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.age == rhs.age && lhs.name == rhs.name
    }

}

func XCTAssertDoesContain<S: Sequence, Value: Equatable>(
    _ value: Value,
    in sequence: S
    ) where S.Element == Value
{
    XCTAssert(sequence.contains(where: { $0 == value }))
}

func XCTAssertDoesNotContain<S: Sequence, Value: Equatable>(
    _ value: Value,
    in sequence: S
    ) where S.Element == Value
{
    XCTAssert(sequence.contains(where: { $0 != value }))
}

class PredictableTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(Predictable().text, "Hello, World!")

        var harry = Person(name: "Harry", age: 21)
        let rosie = Person(name: "Rosie", age: 20)
        var paula = Person(name: "Paula", age: 48)

        harry.pets.append("Alfie")
        paula.pets.append("Alfie")

        let queriedResult = Query(Person.self)
            .for((30...50) ~> \Person.age, \Person.pets ~> "Alfie")
            .by(\Person.age)
            .evaluate([harry, rosie, paula])

        XCTAssertNotEqual(queriedResult.first, rosie)
        XCTAssertDoesNotContain(rosie, in: queriedResult)
//        XCTAssertNotCo

    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
