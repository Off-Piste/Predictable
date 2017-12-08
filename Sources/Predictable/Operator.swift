//
//  Operator.swift
//  Predictable
//
//  Created by Harry Wright on 07/12/2017.
//

import Foundation
import SwiftyCouchDB

public func == <Key>(lhs: Key, rhs: Predicate<Key>) -> Bool {
    return rhs.evaluate(with: lhs)
}

public func == <Key>(lhs: Predicate<Key>, rhs: Key) -> Bool {
    return lhs.evaluate(with: rhs)
}

// MARK: ComparablePredicate

public func == <Key, Value>(
    lhs: KeyPath<Key, Value>,
    rhs: Value
    ) -> ComparablePredicate<Key, Value>
{
    return ComparablePredicate<Key, Value>(keyPath: lhs, is: .equalTo, to: rhs)
}

public func != <Key, Value>(
    lhs: KeyPath<Key, Value>,
    rhs: Value
    ) -> ComparablePredicate<Key, Value>
{
    return ComparablePredicate<Key, Value>(keyPath: lhs, is: .notEqualTo, to: rhs)
}

public func < <Key, Value>(
    lhs: KeyPath<Key, Value>,
    rhs: Value
    ) -> ComparablePredicate<Key, Value>
{
    return ComparablePredicate<Key, Value>(keyPath: lhs, is: .lessThan, to: rhs)
}

public func <= <Key, Value>(
    lhs: KeyPath<Key, Value>,
    rhs: Value
    ) -> ComparablePredicate<Key, Value>
{
    return ComparablePredicate<Key, Value>(keyPath: lhs, is: .lessThanOrEqualTo, to: rhs)
}

public func > <Key, Value>(
    lhs: KeyPath<Key, Value>,
    rhs: Value
    ) -> ComparablePredicate<Key, Value>
{
    return ComparablePredicate<Key, Value>(keyPath: lhs, is: .greaterThan, to: rhs)
}

public func >= <Key, Value>(
    lhs: KeyPath<Key, Value>,
    rhs: Value
    ) -> ComparablePredicate<Key, Value>
{
    return ComparablePredicate<Key, Value>(keyPath: lhs, is: .greaterThanOrEqualTo, to: rhs)
}

// MARK: RangePredicate

infix operator <~

public func ~> <Key, Value, Range>(
    lhs: Range,
    rhs: KeyPath<Key, Value>
    ) -> RangePredicate<Key, Value, Range> where Range.Bound == Value
{
    return RangePredicate<Key, Value, Range>(keyPath: rhs , in: lhs)
}

public func <~ <Key, Value, Range>(
    lhs: KeyPath<Key, Value> ,
    rhs: Range
    ) -> RangePredicate<Key, Value, Range> where Range.Bound == Value
{
    return RangePredicate<Key, Value, Range>(keyPath: lhs , in: rhs)
}

// MARK: ContainsPredicate

public func ~> <Key, Value, Element>(
    lhs: KeyPath<Key, Value>,
    rhs: Element
    ) -> ContainsPredicate<Key, Value, Element> where Value.Element == Element
{
    return ContainsPredicate<Key, Value, Element>(keyPath: lhs , contains: rhs)
}

public func <~ <Key, Value, Element>(
    lhs: Element,
    rhs: KeyPath<Key, Value>
    ) -> ContainsPredicate<Key, Value, Element> where Value.Element == Element
{
    return ContainsPredicate<Key, Value, Element>(keyPath: rhs , contains: lhs)
}
