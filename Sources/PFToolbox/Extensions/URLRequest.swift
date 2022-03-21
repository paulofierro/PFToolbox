//
//  URLRequest.swift
//  
//
//  Created by Paulo Fierro.
//

import Foundation

public extension URLRequest {
    /// Adds HTTP headers to a request
    mutating func addHeaders(_ headers: HTTPHeaders?) {
        guard let headers = headers else {
            return
        }
        for (key, value) in headers {
            setValue(value.rawValue, forHTTPHeaderField: key.rawValue)
        }
    }
}
