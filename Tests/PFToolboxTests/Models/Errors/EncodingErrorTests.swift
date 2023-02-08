//
//   EncodingErrorTests.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class EncodingErrorTests: XCTestCase {
    func testLocalizedErrors() throws {
        let error: EncodingError = .noData
        XCTAssertEqual(error.localizedDescription, "Encoded JSON is nil")
    }
}
