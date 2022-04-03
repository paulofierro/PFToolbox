//
//  Encodable.swift
//  
//
//  Created by Paulo Fierro.
//

import Foundation

public extension Encodable {

    /// Convert the data to JSON
    func toJSON() throws -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes, .sortedKeys]
        
        let jsonData = try encoder.encode(self)
        let jsonString = String(data: jsonData, encoding: .utf8)
        return jsonString
    }
}
