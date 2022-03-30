//
//  Array.swift
//  
//
//  Created by Paulo Fierro.
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