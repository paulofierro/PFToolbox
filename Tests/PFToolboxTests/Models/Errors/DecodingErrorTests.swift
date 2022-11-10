//
//   DecodingErrorTests.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class DecodingErrorTests: XCTestCase {
    func testLocalizedErrors() throws {
        let error: DecodingError = .fileNotFound("readme.txt")
        XCTAssertEqual(error.localizedDescription, "File not found: readme.txt")
    }
}
