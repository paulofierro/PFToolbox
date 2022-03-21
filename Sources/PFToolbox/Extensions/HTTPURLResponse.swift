//
//  HTTPURLResponse.swift
//  
//
//  Created by Paulo Fierro.
//

import Foundation

public extension HTTPURLResponse {
    /// Returns an error if the HTTP response status code maps to an error.
    var statusCodeError: NetworkError? {
        switch statusCode {
        case 200...299:
            return nil

        case 404:
            return NetworkError.notFound(statusCode)

        case 401...499:
            return NetworkError.authenticationError(statusCode)

        case 500...599:
            return NetworkError.badRequest(statusCode)

        case 600:
            return NetworkError.outdated(statusCode)

        default:
            return NetworkError.badResponse(statusCode)
        }
    }
}
