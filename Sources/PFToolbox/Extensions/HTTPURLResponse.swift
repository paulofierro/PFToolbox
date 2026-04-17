//
//   HTTPURLResponse.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public extension HTTPURLResponse {
    /// Returns an error if the HTTP response status code maps to an error.
    var statusCodeError: NetworkError? {
        switch statusCode {
        case 200 ... 299:
            nil

        case 404:
            NetworkError.notFound(statusCode)

        case 400 ... 499:
            NetworkError.authenticationError(statusCode)

        case 500 ... 599:
            NetworkError.serverError(statusCode)

        case 600:
            NetworkError.outdated(statusCode)

        default:
            NetworkError.badResponse(statusCode)
        }
    }
}
