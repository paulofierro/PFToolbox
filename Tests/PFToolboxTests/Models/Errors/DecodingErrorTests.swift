//
//   DecodingErrorTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class DecodingErrorTests: XCTestCase {
    func testLocalizedErrors() {
        let error: DecodingError = .fileNotFound("readme.txt")
        XCTAssertEqual(error.localizedDescription, "File not found: readme.txt")
    }
}
