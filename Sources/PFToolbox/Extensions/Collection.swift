//
//  Collection.swift
//  
//
//  Created by Paulo Fierro.
//

import Foundation

public extension Optional where Wrapped: Collection {

    /// Sugar for asking an optional collection if it's both not empty and contains elements
    var isNotEmpty: Bool {
        return !isEmptyOrNil
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
        return !isEmpty
    }
}
