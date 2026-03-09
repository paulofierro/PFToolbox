//
//   Encodable.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

public extension Encodable {
    /// Convert the data to JSON
    func toJSON() throws -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes, .sortedKeys]

        let jsonData = try encoder.encode(self)
        return String(data: jsonData, encoding: .utf8)
    }
}
