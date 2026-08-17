//
//   URLRequest.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public extension URLRequest {
    /// Creates and initializes a URLRequest with the given URL and cache policy.
    /// - parameter: url The URL for the request.
    /// - parameter: httpMethod The HTTP method to use for the request
    /// - parameter: cachePolicy The cache policy for the request. Defaults to `.useProtocolCachePolicy`
    /// - parameter: timeoutInterval The timeout interval for the request. See the commentary for the `timeoutInterval`
    /// for more information on timeout intervals. Defaults to 60.0
    init(
        url: URL,
        httpMethod: HTTPMethod,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        timeoutInterval: TimeInterval = 60.0
    ) {
        self.init(
            url: url,
            cachePolicy: cachePolicy,
            timeoutInterval: timeoutInterval
        )
        self.httpMethod = httpMethod.rawValue
    }

    /// Creates a URLRequest for an endpoint
    /// - parameter: route The endpoint route
    /// - parameter: cachePolicy The cache policy for the request. Defaults to `.useProtocolCachePolicy`
    /// - parameter: timeoutInterval The timeout interval for the request. See the commentary for the `timeoutInterval`
    /// for more information on timeout intervals. Defaults to 60.0
    static func buildRequest(
        from route: Endpoint,
        cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData,
        timeoutInterval: TimeInterval = 60.0
    ) throws -> Self {
        let url = route.baseURL.appendingPathComponent(route.path)
        var request = URLRequest(
            url: url,
            cachePolicy: cachePolicy,
            timeoutInterval: timeoutInterval
        )

        request.httpMethod = route.method.rawValue
        request.addHeaders(route.headers)
        request.addURLParameters(route.urlParameters)

        switch route.task {
        case .request:
            // Do nothing
            break
        case .requestWithJSONPayload(let payload):
            if let payload {
                guard let json = payload.toJSONObject() else {
                    throw EncodingError.noData
                }
                try request.addJSONPayload(json)
            }
        case .requestWithForm(let params):
            try request.addURLEncodedForm(params: params)
        }
        return request
    }

    /// Add URL parameters to a request, preserving any query items already present on the URL
    mutating func addURLParameters(_ parameters: Parameters) {
        guard let url, parameters.isNotEmpty else { return }

        // Add a query item for each param. Values are passed through unescaped because
        // `URLComponents` percent-encodes them when it builds the URL below.
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = parameters
            .sorted(by: {
                $0.key < $1.key
            })
            .map { key, value in
                URLQueryItem(
                    name: key,
                    value: "\(value)"
                )
            }
        let existingItems = components?.queryItems ?? []
        components?.queryItems = existingItems + queryItems

        // Finally replace our URL, leaving it untouched if the components could not be rebuilt
        guard let newURL = components?.url else { return }
        self.url = newURL
    }

    /// Add a JSON payload to a request. Also adds required HTTP headers if these are missing
    mutating func addJSONPayload(_ json: JSON) throws {
        do {
            guard JSONSerialization.isValidJSONObject(json) else {
                throw EncodingError.encodingFailed
            }
            httpBody = try JSONSerialization.data(withJSONObject: json)
            // Only the size is logged. The body routinely carries credentials and personal
            // data, and log messages outlive the process that wrote them.
            log.debug("Encoded a JSON payload of \(httpBody?.count ?? 0) bytes")

            // Add the content-type header if its not already present
            addContentTypeHeader(for: .jsonContent)
        } catch {
            throw EncodingError.encodingFailed
        }
    }

    /// Adds a dictionary of string values to a request. Also adds required HTTP headers if these are missing
    mutating func addURLEncodedForm(params: [String: String]) throws {
        let parameters = params.map { key, value in
            "\(key.percentEscapeString())=\(value.percentEscapeString())"
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
    /// Adds the content-type header, leaving any value the caller already set in place
    private mutating func addContentTypeHeader(for type: HTTPHeaderValue) {
        let field = HTTPHeaderField.contentType.rawValue
        guard value(forHTTPHeaderField: field) == nil else { return }
        setValue(type.rawValue, forHTTPHeaderField: field)
    }
}
