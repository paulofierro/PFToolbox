//
//   Payload.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]
public typealias Parameters = [String: Any]

/// An encodable object that can be encoded as JSON to be sent to the API.
///
/// The requirement is named `toJSONObject` rather than `toJSON` so that it does not read as an
/// overload of `Encodable.toJSON()`, which returns a JSON *string* and throws.
public protocol Payload: Encodable {
    func toJSONObject() -> JSON?
}

public extension Payload {
    /// Enables subscript behavior for objects.
    /// Each lookup re-encodes the receiver, so hold on to `toJSONObject()` when reading several keys.
    subscript(key: String) -> Any? {
        guard let jsonObj = toJSONObject() else {
            return nil
        }
        return jsonObj[key]
    }

    /// Converts a Codable object to a JSON dictionary
    func toJSONObject() -> JSON? {
        let encoder = JSONEncoder()

        guard let data = try? encoder.encode(self),
              let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON else {
            return nil
        }
        return jsonObj
    }
}
