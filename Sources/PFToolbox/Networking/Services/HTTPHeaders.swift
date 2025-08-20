//
//   HTTPHeaders.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [HTTPHeaderField: HTTPHeaderValue]

public enum HTTPHeaderField: String {
    case accept = "Accept"
    case contentType = "Content-Type"
    case userAgent = "User-Agent"
    case authorization = "Authorization"
    case pragma = "Pragma"
    case cacheControl = "Cache-Control"
    case acceptEncoding = "Accept-Encoding"
}

public enum HTTPHeaderValue {
    case jsonContent
    case urlEncodedFormContent
    case basicAuthorization(token: String)
    case bearer(token: String)
    case safariUserAgent
    case noCache
    case gzipEncoding
    case generic(string: String)

    var rawValue: String {
        switch self {
        case .jsonContent:
            "application/json"
        case .urlEncodedFormContent:
            "application/x-www-form-urlencoded"
        case .basicAuthorization(let token):
            "Basic \(token)"
        case .bearer(let token):
            "Bearer \(token)"
        case .safariUserAgent:
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Safari/605.1.15"
        case .noCache:
            "no-cache"
        case .gzipEncoding:
            "gzip"
        case .generic(let string):
            string
        }
    }
}
