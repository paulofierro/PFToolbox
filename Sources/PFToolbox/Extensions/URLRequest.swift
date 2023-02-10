//
//   URLRequest.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

import Foundation

public extension URLRequest {
    /// Creates and initializes a URLRequest with the given URL and cache policy.
    /// - parameter: url The URL for the request.
    /// - parameter: httpMethod The HTTP method to use for the request
    /// - parameter: cachePolicy The cache policy for the request. Defaults to `.useProtocolCachePolicy`
    /// - parameter: timeoutInterval The timeout interval for the request. See the commentary for the `timeoutInterval` for more information on timeout intervals. Defaults to 60.0
    init(url: URL, httpMethod: HTTPMethod, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 60.0) {
        self.init(
            url: url,
            cachePolicy: cachePolicy,
            timeoutInterval: timeoutInterval
        )
        self.httpMethod = httpMethod.rawValue
    }

    /// Adds HTTP headers to a request
    mutating func addHeaders(_ headers: HTTPHeaders?) {
        guard let headers else {
            return
        }
        for (key, value) in headers {
            setValue(value.rawValue, forHTTPHeaderField: key.rawValue)
        }
    }

    /// Add a JSON payload to a request. Also adds required HTTP headers if these are missing
    mutating func addJSONPayload(_ json: JSON) throws {
        do {
            guard JSONSerialization.isValidJSONObject(json) else {
                throw EncodingError.encodingFailed
            }
            httpBody = try JSONSerialization.data(withJSONObject: json)
            #if DEBUG
                if let prettyJSON = httpBody?.prettyPrinted() {
                    log.debug("JSON: \(prettyJSON)")
                }
            #endif

            // Add the content-type header if its not already present
            addContentTypeHeader(for: .jsonContent)
        } catch {
            throw EncodingError.encodingFailed
        }
    }
    
    /// Adds a dictionary of string values to a request. Also adds required HTTP headers if these are missing
    mutating func addURLEncodedForm(params: [String : String]) throws {
        let parameters = params.map { key, value in
            "\(key)=\(value.percentEscapeString())"
        }

        httpBody = parameters
            .joined(separator: "&")
            .data(using: .utf8)
        addContentTypeHeader(for: .urlEncodedFormContent)
    }
}

// MARK: - Helpers

extension URLRequest {
    /// Adds the content-type header if its not already present
    private mutating func addContentTypeHeader(for type: HTTPHeaderValue) {
        // Add the content-type header if its not already present
        let contentType = HTTPHeaderField.contentType.rawValue
        if value(forHTTPHeaderField: type.rawValue) == nil {
            setValue(type.rawValue, forHTTPHeaderField: contentType)
        }
    }
}
