//
//   NSMutableAttributedString.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

import Foundation

public extension NSMutableAttributedString {
    /// Helper method that applies attributes to the entire string.
    func addAttributes(_ attributes: [NSAttributedString.Key: Any]) {
        addAttributes(attributes, range: NSRange(location: 0, length: length))
    }
}
