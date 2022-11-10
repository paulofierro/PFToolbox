//
//   Collection.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

import Foundation

public extension Optional where Wrapped: Collection {
    /// Sugar for asking an optional collection if it's both not empty and contains elements
    var isNotEmpty: Bool {
        !isEmptyOrNil
    }

    /// Sugar for asking an optional collection if it's either empty or nil
    var isEmptyOrNil: Bool {
        if let strongSelf = self {
            return strongSelf.isEmpty
        }
        return true
    }
}

public extension Collection {
    /// Sugar for asking an collection if it's not empty
    var isNotEmpty: Bool {
        !isEmpty
    }
}

// MARK: - Equatable Collections

public extension Collection where Self.Element: Equatable {
    /// Returns true if the collection only contains the single element
    func onlyContains(_ element: Self.Element) -> Bool {
        guard count == 1 else {
            return false
        }
        return contains(where: { $0 == element })
    }
}
