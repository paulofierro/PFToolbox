//
//   StringProtocol.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

import Foundation

public extension StringProtocol {
    /// Returns `true` if `other` is non-empty and not contained within `self` by
    /// case-sensitive, non-literal search. Otherwise, returns `false`.
    ///
    /// Equivalent to `self.range(of: other) == nil`
    func doesNotContain(_ other: some StringProtocol) -> Bool {
        !contains(other)
    }
}
