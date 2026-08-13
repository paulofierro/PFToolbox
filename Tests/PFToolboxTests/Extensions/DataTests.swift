//
//   DataTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

struct DataTests {
    @Test func `loading a missing file`() {
        #expect(throws: DecodingError.fileNotFound("fileNotFound.txt")) {
            try Data.load(filename: "fileNotFound.txt")
        }
    }

    @Test func `loading from an explicit bundle`() {
        #expect(throws: DecodingError.fileNotFound("fileNotFound.txt")) {
            try Data.load(filename: "fileNotFound.txt", in: Bundle(for: BundleMarker.self))
        }
    }

    /// Gives `Bundle(for:)` a class in the test bundle to resolve against
    private final class BundleMarker {}

    @Test func `pretty printing`() throws {
        let json = ["name": "Paulo"]
        let data = try JSONSerialization.data(withJSONObject: json)

        #expect(data.prettyPrinted() == """
        {
          "name" : "Paulo"
        }
        """)
    }

    @Test func `invalid pretty printing`() {
        let string = "Invalid JSON"
        let data = string.data(using: .utf8)
        #expect(data?.prettyPrinted() == nil)
    }
}
