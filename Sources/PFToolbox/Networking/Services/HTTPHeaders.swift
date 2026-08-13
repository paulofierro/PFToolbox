//
//   HTTPHeaders.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [HTTPHeaderField: HTTPHeaderValue]

/// HTTP field names are case-insensitive, and `.custom("Accept")` names the same field as
/// `.accept`. Both are compared and hashed on the lowercased `rawValue` so that spelling a
/// field two different ways cannot produce the same header twice on one request.
///
/// Because they compare equal, a dictionary literal naming one field twice traps the way any
/// duplicate-key literal does. Assign through the subscript when a key may already be present:
///
/// ```swift
/// var headers: HTTPHeaders = [.accept: .jsonContent]
/// headers[.custom("Accept")] = .gzipEncoding // replaces, rather than duplicating
/// ```
public enum HTTPHeaderField: Hashable {
    case accept
    case contentType
    case userAgent
    case authorization
    case pragma
    case cacheControl
    case acceptEncoding
    case custom(String)

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue.lowercased() == rhs.rawValue.lowercased()
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue.lowercased())
    }

    public var rawValue: String {
        switch self {
        case .accept: "Accept"
        case .contentType: "Content-Type"
        case .userAgent: "User-Agent"
        case .authorization: "Authorization"
        case .pragma: "Pragma"
        case .cacheControl: "Cache-Control"
        case .acceptEncoding: "Accept-Encoding"
        case .custom(let name): name
        }
    }
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

    public var rawValue: String {
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
