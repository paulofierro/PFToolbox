//
//   Array.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

import Foundation

public extension Array {
    /// Returns an element at a specific index, or nil if the index is out of bounds.
    subscript(safeIndex index: Int) -> Element? {
        guard index >= startIndex, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
