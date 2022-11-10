//
//   URLRequest.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

import Foundation

public extension URLRequest {
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
            addContentTypeHeader(for: HTTPHeaderValue.jsonContent.rawValue)
        } catch {
            throw EncodingError.encodingFailed
        }
    }
}

// MARK: - Helpers

extension URLRequest {
    /// Adds the content-type header if its not already present
    private mutating func addContentTypeHeader(for type: String) {
        // Add the content-type header if its not already present
        let contentType = HTTPHeaderField.contentType.rawValue
        if value(forHTTPHeaderField: type) == nil {
            setValue(type, forHTTPHeaderField: contentType)
        }
    }
}
