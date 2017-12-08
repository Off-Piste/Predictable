//
//  Query.swift
//  Predictable
//
//  Created by Harry Wright on 07/12/2017.
//

import Foundation
@testable import SwiftyCouchDB

internal class KeyedSorter<Key> {

    func sort(_ lhs: Key, with rhs: Key) -> Bool { fatalError("Cannot Use") }

}

internal final class Sorter<Key, Value: Comparable>: KeyedSorter<Key> {

    var keyPath: KeyPath<Key, Value>

    var ascending: Bool

    internal init(keyPath: KeyPath<Key, Value>, ascending: Bool = true) {
        self.keyPath = keyPath
        self.ascending = ascending
    }

    internal override func sort(_ lhs: Key, with rhs: Key) -> Bool {
        if ascending {
            return lhs[keyPath: keyPath] < rhs[keyPath: keyPath]
        } else {
            return lhs[keyPath: keyPath] > rhs[keyPath: keyPath]
        }
    }
}

/// <#Description#>
public typealias Evaluation<Key> = ([Key]?, Error?) -> Void

/// <#Description#>
public final class Query<Key> {

    var type: Key.Type

    var predicates: [Predicate<Key>] = []

    var sort: KeyedSorter<Key>? = nil

    /// <#Description#>
    ///
    /// - Parameter type: <#type description#>
    public init(_ type: Key.Type) {
        self.type = type
    }

    /// <#Description#>
    ///
    /// - Parameter predicates: <#predicates description#>
    /// - Returns: <#return value description#>
    public func `for`(_ predicates: Predicate<Key>...) -> Query {
        self.predicates = predicates
        return self
    }

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - keyPath: <#keyPath description#>
    ///   - ascending: <#ascending description#>
    /// - Returns: <#return value description#>
    public func by<Value: Comparable>(
        _ keyPath: KeyPath<Key, Value>,
        ascending: Bool = true
        ) -> Query
    {
        self.sort = Sorter<Key, Value>(keyPath: keyPath, ascending: ascending)

        return self
    }

    /// <#Description#>
    ///
    /// - Parameter objects: <#objects description#>
    /// - Returns: <#return value description#>
    public func evaluate(_ objects: [Key]) -> [Key] {
        let filteredDocuments = objects.filter(where: self.predicates)

        let sortedDocuments = self.sort != nil ?
            filteredDocuments.sorted(by: self.sort!) : filteredDocuments

        return sortedDocuments
    }
}

extension Query where Key: DBDocument {

    /// <#Description#>
    ///
    /// - Parameter callback: <#callback description#>
    public func evaluate(
        decoder: JSONDecoder = JSONDecoder(),
        _ callback: @escaping (Evaluation<Key>)
        )
    {
        self.type.all(decoder: decoder) { (documents, error) in
            if let error = error { callback(nil, error); return }
            callback(self.evaluate(documents!), nil)
        }
    }

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - design: <#design description#>
    ///   - view: <#view description#>
    ///   - callback: <#callback description#>
    public func evaluate(
        in design: Database.Design,
        with view: DBDesignView,
        _ callback: @escaping (Evaluation<Key>)
        )
    {
        self.type.query(by: view, in: design) { (documents, error) in
            if let error = error { callback(nil, error); return }

            callback(self.evaluate(documents!), nil)
        }
    }
}

//extension 

