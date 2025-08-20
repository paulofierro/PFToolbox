//
//   NetworkError.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

/// Errors that occur during network operations
public enum NetworkError: Error {
    case authenticationError(Int)
    case badRequest(Int)
    case failed(Int)
    case noData(Int)
    case outdated(Int)
    case notFound(Int)
    case badResponse(Int)
    case invalidResponse
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        "\(self)"
    }
}

extension NetworkError: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }
}
