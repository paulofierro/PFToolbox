//
//   Dictionary.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

public extension Dictionary {
    /// Adds/overwrites all the values from the new dictionary
    mutating func merge(dict: [Key: Value]?) {
        guard let dict else { return }

        for (key, value) in dict {
            updateValue(value, forKey: key)
        }
    }
}
