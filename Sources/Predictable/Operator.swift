//
//  Operator.swift
//  Predictable
//
//  Created by Harry Wright on 07/12/2017.
//

import Foundation

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
