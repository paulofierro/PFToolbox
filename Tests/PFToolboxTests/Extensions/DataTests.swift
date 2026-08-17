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

    @Test func `loading a resource from a bundle`() throws {
        let contents = Data("hello world".utf8)
        let bundle = try TemporaryBundle(
            info: ["CFBundleName": "Fixture"],
            resources: ["greeting.txt": contents]
        )
        defer { bundle.remove() }

        #expect(try Data.load(filename: "greeting.txt", in: bundle.value) == contents)
    }

    @Test func `loading a missing file from an explicit bundle`() throws {
        let bundle = try TemporaryBundle(info: ["CFBundleName": "Fixture"])
        defer { bundle.remove() }

        #expect(throws: DecodingError.fileNotFound("nope.txt")) {
            try Data.load(filename: "nope.txt", in: bundle.value)
        }
    }

    /// Non-UTF8 bytes must survive, which the old String round-trip could not manage
    @Test func `loading binary data`() throws {
        let contents = Data([0x00, 0xff, 0xfe, 0x80, 0x01])
        let bundle = try TemporaryBundle(
            info: ["CFBundleName": "Fixture"],
            resources: ["blob.bin": contents]
        )
        defer { bundle.remove() }

        #expect(try Data.load(filename: "blob.bin", in: bundle.value) == contents)
    }

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
