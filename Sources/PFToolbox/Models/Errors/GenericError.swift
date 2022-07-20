//
//  GenericError.swift
//  
//
//  Created by Paulo Fierro.
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
            return string
        }
    }
}

extension GenericError: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }
}
