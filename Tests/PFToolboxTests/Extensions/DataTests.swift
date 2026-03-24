//
//   DataTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

struct DataTests {
    @Test func `loading data`() {
        #expect(throws: (any Error).self) {
            try Data.load(filename: "fileNotFound.txt")
        }
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
