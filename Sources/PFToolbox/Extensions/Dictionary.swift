//
//   Dictionary.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

import Foundation

public extension Dictionary {
    /// Adds/overwrites all the values from the new dictionary
    mutating func merge(dict: [Key: Value]?) {
        guard let dict else { return }

        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
