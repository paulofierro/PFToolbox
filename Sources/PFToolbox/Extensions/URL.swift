//
//  URL.swift
//  
//
//  Created by Paulo Fierro.
//

import Foundation

public extension URL {
    /// Attempts to create a URL, wrapped in a `fatalError`
    static func from(string: String) -> URL {
        guard let url = URL(string: string) else {
            fatalError("Could not create URL from \(string)")
        }
        return url
    }
}