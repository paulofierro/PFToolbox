//
//   DataTests.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class DataTests: XCTestCase {
    func testLoadingData() throws {
        let data = try Data.load(filename: "fileNotFound.txt")
        XCTAssertNil(data)
    }

    func testPrettyPrinting() throws {
        let json = ["name": "Paulo"]
        let data = try JSONSerialization.data(withJSONObject: json)
        XCTAssertNotNil(data)

        XCTAssertEqual(data.prettyPrinted(), """
        {
          "name" : "Paulo"
        }
        """)
    }

    func testInvalidPrettyPrinting() throws {
        let string = "Invalid JSON"
        let data = string.data(using: .utf8)
        XCTAssertNil(data?.prettyPrinted())
    }
}
