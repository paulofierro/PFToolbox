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
            // Success
            nil

        case 304:
            // Not Modified is the successful outcome of a conditional request
            nil

        case 401, 403:
            // Unauthorized and Forbidden are the only genuine authentication failures
            NetworkError.authenticationError(statusCode)

        case 404:
            NetworkError.notFound(statusCode)

        case 410, 426:
            // Gone and Upgrade Required both mean the client is out of date
            NetworkError.outdated(statusCode)

        case 400 ... 499:
            // Any other client error
            NetworkError.failed(statusCode)

        case 500 ... 599:
            NetworkError.serverError(statusCode)

        default:
            // Anything outside the ranges defined by RFC 9110
            NetworkError.badResponse(statusCode)
        }
    }
}
