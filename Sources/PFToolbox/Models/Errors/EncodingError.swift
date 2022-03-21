//
//  EncodingError.swift
//  
//
//  Created by Paulo Fierro.
//

import Foundation

/// Errors that can occur in the JSON encoding process
public enum EncodingError: Error {
    case noData
}

extension EncodingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData:
            return "Encoded JSON is nil"
        }
    }
}
