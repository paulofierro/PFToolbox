//
//   EncodingError.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

/// Errors that can occur in the JSON encoding process
public enum EncodingError: Error, Equatable {
    case noData
    case encodingFailed
}

extension EncodingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData:
            "Encoded JSON is nil"
        case .encodingFailed:
            "Failed to encode JSON"
        }
    }
}
