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

    /// Add URL parameters to a request
    mutating func addURLParameters(_ parameters: Parameters) {
        guard let url, parameters.isNotEmpty else { return }

        // Add a query item for each param
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters
            .sorted(by: {
                $0.key < $1.key
            })
            .map { key, value in
                URLQueryItem(
                    name: key,
                    value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                )
            }

        // Finally replace our URL
        self.url = components?.url
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
    mutating func addURLEncodedForm(params: [String: String]) throws {
        let parameters = params.map { key, value in
            "\(key)=\(value.percentEscapeString())"
        }

        httpBody = parameters
            .joined(separator: "&")
            .data(using: .utf8)
        addContentTypeHeader(for: .urlEncodedFormContent)
    }
}

// MARK: - Header Methods

public extension URLRequest {
    /// Adds HTTP headers to a request
    mutating func addHeaders(_ headers: HTTPHeaders?) {
        headers?.forEach { key, value in
            addValue(value, for: key)
        }
    }

    /// Sets a header value for a defined header field
    mutating func addValue(_ value: HTTPHeaderValue, for header: HTTPHeaderField) {
        addValue(value.rawValue, forHTTPHeaderField: header.rawValue)
    }

    /// Sets an arbitrary string for a defined header field
    mutating func addValue(_ value: String, for header: HTTPHeaderField) {
        addValue(value, forHTTPHeaderField: header.rawValue)
    }
}

// MARK: - Helpers

extension URLRequest {
    /// Adds the content-type header if its not already present
    private mutating func addContentTypeHeader(for type: HTTPHeaderValue) {
        guard value(forHTTPHeaderField: type.rawValue) == nil else { return }
        setValue(type.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    }
}
