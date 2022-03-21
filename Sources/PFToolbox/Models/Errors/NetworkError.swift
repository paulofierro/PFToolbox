//
//  NetworkError.swift
//  
//
//  Created by Paulo Fierro.
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
        switch self {
        case .authenticationError(let code),
             .badRequest(let code),
             .failed(let code),
             .noData(let code),
             .outdated(let code),
             .notFound(let code),
             .badResponse(let code):
            return "\(self) [\(code)]"

        case .invalidResponse:
            return "\(self)"
        }
    }
}

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }
}
