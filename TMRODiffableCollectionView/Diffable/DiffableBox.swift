//
//  DiffableBox.swift
//  TMRODiffableCollectionView
//
//  Created by Benji Dodgson on 11/9/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import Foundation

/// An object that can be wrapped in a DiffableBox.
protocol Diffable: Hashable {
    func diffIdentifier() -> NSObjectProtocol
}

/// IGListDiffable can only perform diffs on class objects, which are reference types.
/// This object wraps value types, such as structs, in a reference type to make them compatible with diffing algorithms.
final class DiffableBox<T: Diffable>: ListDiffable {
    let value: T
    let equal: (T, T) -> Bool

    init(value: T, equal: @escaping (T, T) -> Bool) {
        self.value = value
        self.equal = equal
    }

    public func diffIdentifier() -> NSObjectProtocol {
        return self.value.diffIdentifier()
    }

    public func isEqual(toDiffableObject obj: ListDiffable?) -> Bool {
        if let other = obj as? DiffableBox<T> {
            return equal(value, other.value)
        }
        return false
    }
}
