//
//  Predictable.swift
//  Predictable
//
//  Created by Harry Wright on 07/12/2017.
//

import SwiftyCouchDB

/// <#Description#>
open class AnyPredicate {

    /// <#Description#>
    open var predicteFormat: String {
        return "Unknown"
    }

}

// Keep it pure swift for Linux
#if !os(Linux)

import Foundation

/// <#Description#>
final public class OPPredicate: AnyPredicate, ExpressibleByStringLiteral {

    public typealias StringLiteralType = String

    var _nsPredicate: NSPredicate

    init(format: String) {
        self._nsPredicate = NSPredicate(format: format)
    }

    public convenience init(stringLiteral value: OPPredicate.StringLiteralType) {
        self.init(format: value)
    }

    public override var predicteFormat: String {
        return _nsPredicate.predicateFormat
    }

}

#endif

/// <#Description#>
open class Predicate<Key>: AnyPredicate {

    /// <#Description#>
    ///
    /// - Parameter object: <#object description#>
    /// - Returns: <#return value description#>
    open func evaluate(with object: Key) -> Bool {
        fatalError("Please use subclass")
    }

}

/// <#Description#>
public final class ComparablePredicate<Key: DBDocument, Value: Comparable>: Predicate<Key> {

    /// <#Description#>
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

/// <#Description#>
public final class RangePredicate<Key: DBDocument, Value, Range: RangeExpression>: Predicate<Key> where Range.Bound == Value {

    internal var keyPath: KeyPath<Key, Value>

    internal var range: Range

    internal init(keyPath: KeyPath<Key, Value>, in range: Range) {
        self.keyPath = keyPath
        self.range = range
    }
    
    public override func evaluate(with object: Key) -> Bool {
        return range.contains(object[keyPath: keyPath])
    }

}

public final class ContainsPredicate<Key: DBDocument, Value: Sequence, Element: Equatable>: Predicate<Key> where Value.Element == Element {

    internal var keyPath: KeyPath<Key, Value>

    internal var object: Element

    internal init(keyPath: KeyPath<Key, Value>, contains object: Element) {
        self.keyPath = keyPath
        self.object = object
    }

    public override func evaluate(with object: Key) -> Bool {
        return object[keyPath: keyPath].contains(self.object)
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
