//
//   HTTPURLResponse.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

public extension HTTPURLResponse {
    /// Returns an error if the HTTP response status code maps to an error.
    var statusCodeError: NetworkError? {
        switch statusCode {
        case 200 ... 299:
            nil

        case 404:
            NetworkError.notFound(statusCode)

        case 401 ... 499:
            NetworkError.authenticationError(statusCode)

        case 500 ... 599:
            NetworkError.badRequest(statusCode)

        case 600:
            NetworkError.outdated(statusCode)

        default:
            NetworkError.badResponse(statusCode)
        }
    }
}
