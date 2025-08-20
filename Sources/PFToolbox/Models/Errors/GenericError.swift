//
//   GenericError.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

/// Generic errors
public enum GenericError: Error {
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

extension GenericError: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }
}
