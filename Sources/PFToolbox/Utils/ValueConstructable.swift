//
//   ValueConstructable.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

public protocol ValueConstructable {
    // Defines the value type that is stored
    associatedtype Item

    /// The default value to use when none can be found for the value that was provided.
    static func defaultValue() -> Self

    /// Returns the case for this enum that can be constructed from the value.
    static func from(_ value: Item) -> Self

    /// Returns the case for this enum that can be constructed from the optional value.
    static func from(_ value: Item?) -> Self
}

// Allows for generic construction of value-based enums from raw values
public extension ValueConstructable where Self: RawRepresentable, Self.RawValue == Item {
    /// Returns a case based on the raw value passed in, or the default value if none is found.
    static func from(_ value: Item) -> Self {
        if let object = Self(rawValue: value) {
            return object
        }
        log.warn("Could not find a \(Self.self) for \"\(value)\"")
        return defaultValue()
    }

    /// Returns a case based on the optional, raw value passed in, or the default value if none is found.
    static func from(_ value: Item?) -> Self {
        guard let value else {
            return defaultValue()
        }
        return from(value)
    }
}
