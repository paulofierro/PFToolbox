//
//  NSMutableAttributedString.swift
//  
//
//  Created by Paulo Fierro.
//

import Foundation

public extension NSMutableAttributedString {

    /// Helper method that applies attributes to the entire string.
    func addAttributes(_ attributes: [NSAttributedString.Key: Any]) {
        addAttributes(attributes, range: NSRange(location: 0, length: length))
    }
}
