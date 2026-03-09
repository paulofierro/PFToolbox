//
//   DataTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

struct DataTests {
    @Test func loadingData() throws {
        let data = try Data.load(filename: "fileNotFound.txt")
        #expect(data == nil)
    }

    @Test func prettyPrinting() throws {
        let json = ["name": "Paulo"]
        let data = try JSONSerialization.data(withJSONObject: json)

        #expect(data.prettyPrinted() == """
        {
          "name" : "Paulo"
        }
        """)
    }

    @Test func invalidPrettyPrinting() {
        let string = "Invalid JSON"
        let data = string.data(using: .utf8)
        #expect(data?.prettyPrinted() == nil)
    }
}
