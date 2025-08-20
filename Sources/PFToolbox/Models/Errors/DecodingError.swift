//
//   DecodingError.swift
//   Copyright © Paulo Fierro. All rights reserved.
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
            "File not found: \(filename)"
        }
    }
}

extension DecodingError: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }
}
