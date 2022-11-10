//
//   String.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

import Foundation

public extension String {
    /// Matches the behaviour found in NSString
    var boolValue: Bool {
        switch lowercased() {
        case "true", "yes", "1":
            return true
        default:
            return false
        }
    }

    /// Returns true if the string is a valid email address
    var isValidEmailAddress: Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: self)
    }

    /// Trims trailing whitespace and newlines
    func trim() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - Subscript Helpers

public extension String {
    /// Returns a string at a specific index, or nil if the index is out of bounds
    subscript(safeIndex index: Int) -> String? {
        guard index < count else {
            return nil
        }
        return self[index ..< index + 1]
    }

    /// Returns a string at a specific index
    subscript(index: Int) -> String {
        self[index ..< index + 1]
    }

    /// Returns a string at a specific range
    subscript(range: Range<Int>) -> String {
        let range = Range(
            uncheckedBounds: (
                lower: max(0, min(count, range.lowerBound)),
                upper: min(count, max(0, range.upperBound))
            )
        )
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

public extension String? {
    /// Matches the behaviour found in NSString
    var boolValue: Bool {
        guard let self else {
            return false
        }
        return self.boolValue
    }
}
