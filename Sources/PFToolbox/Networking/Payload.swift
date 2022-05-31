//
//  Payload.swift
//  
//
//  Created by Paulo Fierro on 31/5/22.
//

import Foundation

public typealias JSON = [String: Any]

/// An encodable object that can be encoded as JSON to be sent to the API.
public protocol Payload: Encodable {
    func toJSON() -> JSON?
}

public extension Payload {

    /// Enables subscript behavior for objects
    subscript(key: String) -> Any? {
        guard let jsonObj = self.toJSON() else {
            return nil
        }
        return jsonObj[key]
    }

    /// Converts a Codable object to JSON
    func toJSON() -> JSON? {
        let encoder = JSONEncoder()

        guard let data = try? encoder.encode(self),
            let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON else {
            return nil
        }
        return jsonObj
    }
}
