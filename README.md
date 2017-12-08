# Predictable

Predictable is a type-safe [SwiftyCouchDB](https://github.com/Off-Piste/SwiftyCouchDB) query API using Swift 4's Smart KeyPaths to extend upon CouchDB's design document querys.

## Requirements

* macOS
* Xcode 9.0+
* Swift 4.0+

## Usage

> Note: Uses SwiftyCouchDB as the CouchDB Wrapper.

Creating your database document object is simple.

```swift
struct User: DBDocument {
  var _id: String
  var name: String
  var email: String
  var age: Int
  var type: String = "user"
}
```

As per with CouchDB you will need to create your design document (`_design/...`)
