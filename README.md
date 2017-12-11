# Predictable

Predictable is a type-safe [SwiftyCouchDB](https://github.com/Off-Piste/SwiftyCouchDB) query API using Swift 4's Smart KeyPaths to extend upon CouchDB's design document querys.

## Requirements

* macOS
* Xcode 9.0+
* Swift 4.0+

## Usage

> Note: Uses SwiftyCouchDB as the CouchDB Wrapper.

Creating your database document object is simple, conforming to `DBDocument` ([Codable](https://developer.apple.com/documentation/swift/codable)) is all that is required.

```swift
struct User: DBDocument {
  var _id: String
  var name: String
  var email: String
  var age: Int
}
```

To create your query without using CouchDB design documents just:

```swift
Query(User.self)
  .for(\User.age > 22)
  .by(\User.age)
  .evaluate { (users, error) in
    /* .. */
  }
```
