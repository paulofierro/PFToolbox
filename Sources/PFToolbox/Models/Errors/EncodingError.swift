//
//   EncodingError.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

import Foundation

/// Errors that can occur in the JSON encoding process
public enum EncodingError: Error {
    case noData
    case encodingFailed
}

extension EncodingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData:
            return "Encoded JSON is nil"
        case .encodingFailed:
            return "Failed to encode JSON"
        }
    }
}

extension EncodingError: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }
}
