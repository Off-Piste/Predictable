//
//  Predictable.swift
//  Predictable
//
//  Created by Harry Wright on 07/12/2017.
//

import SwiftyCouchDB

open class Predicate<Key: DBDocument> {

    open func evaluate(with object: Key) -> Bool {
        fatalError("Please use subclass")
    }

    open var predicteFormat: String {
        fatalError("Please use subclass")
    }

}

public final class ComparablePredicate<Key: DBDocument, Value: Comparable>: Predicate<Key> {

    public enum Operator: String {
        case lessThan = "<"
        case lessThanOrEqualTo = "<="
        case greaterThan = ">"
        case greaterThanOrEqualTo = ">="
        case equalTo = "=="
        case notEqualTo = "!="
    }

    internal var keyPath: KeyPath<Key, Value>

    internal var operatorType: Operator

    internal var value: Value

    internal init(keyPath: KeyPath<Key, Value>, is operatorType: Operator, to value: Value) {
        self.keyPath = keyPath
        self.operatorType = operatorType
        self.value = value
    }

    public override func evaluate(with object: Key) -> Bool {
        return Bool(object: object, predicate: self)
    }
}

extension Bool {

    init<Key, Value>(object: Key, predicate: ComparablePredicate<Key, Value>) {
        switch predicate.operatorType {
        case .lessThan: self = object[keyPath: predicate.keyPath] < predicate.value
        case .lessThanOrEqualTo: self = object[keyPath: predicate.keyPath] <= predicate.value
        case .greaterThan: self = object[keyPath: predicate.keyPath] > predicate.value
        case .greaterThanOrEqualTo: self = object[keyPath: predicate.keyPath] >= predicate.value
        case .equalTo: self = object[keyPath: predicate.keyPath] == predicate.value
        case .notEqualTo: self = object[keyPath: predicate.keyPath] != predicate.value
        }
    }
}
