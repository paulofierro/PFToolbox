//
//   Data.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

import Foundation

public extension Data {
    /// Loads a file from the bundle path
    static func load(filename: String) throws -> Data? {
        let path = Bundle.appPath.appendingPathComponent(filename)
        let contents = try? String(contentsOf: path)
        return contents?.data(using: .utf8)
    }

    /// Pretty prints an object as JSON
    func prettyPrinted() -> String? {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            return String(decoding: jsonData, as: UTF8.self)
        } else {
            let string = String(data: self, encoding: .utf8)
            log.error("JSON data was malformed: \(String(describing: string))")
        }
        return nil
    }
}
