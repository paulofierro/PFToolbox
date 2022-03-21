//
//  DecodingError.swift
//  
//
//  Created by Paulo Fierro.
//

import Foundation

/// Errors that can occur in the JSON decoding process
public enum DecodingError: Error {
    case fileNotFound(String)
}

extension DecodingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fileNotFound(let filename):
            return "File not found: \(filename)"
        }
    }
}
