//
//   Data.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

public extension Data {
    /// Loads a resource shipped inside a bundle, defaulting to the main bundle.
    /// - Throws: `DecodingError.fileNotFound` if the bundle has no such resource.
    static func load(filename: String, in bundle: Bundle = .main) throws -> Data {
        guard let url = bundle.url(forResource: filename, withExtension: nil) else {
            throw DecodingError.fileNotFound(filename)
        }
        return try Data(contentsOf: url)
    }

    /// Pretty prints an object as JSON
    func prettyPrinted() -> String? {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
              let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
            // Only the size is logged. Malformed payloads are still payloads, and may carry
            // credentials or personal data.
            log.error("JSON data was malformed (\(count) bytes)")
            return nil
        }
        return String(bytes: jsonData, encoding: .utf8)
    }
}
