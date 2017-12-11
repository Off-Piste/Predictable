//
//  Array+Predicate.swift
//  Predictable
//
//  Created by Harry Wright on 07/12/2017.
//

import Foundation
import SwiftyCouchDB

func check<Key>(_ object: Key, in predicates: [Predicate<Key>]) -> Bool {
    for predicate in predicates {
        if !predicate.evaluate(with: object) { return false }
    }

    return true
}

extension Sequence {

    func filter(where predicates: [Predicate<Element>]) -> [Element] {
        return self.filter { check($0, in: predicates) }
    }

    func sorted(by sorter: KeyedSorter<Element>) -> [Element] {
        return self.sorted { sorter.sort($0, with: $1) }
    }

}
