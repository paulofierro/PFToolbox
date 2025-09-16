//
//   GenericError.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

/// Generic errors
public enum GenericError: Error, Equatable {
    /// Something happened
    case custom(String)
}

extension GenericError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .custom(let string):
            string
        }
    }
}
