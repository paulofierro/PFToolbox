//
//   EncodingErrorTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class EncodingErrorTests: XCTestCase {
    func testLocalizedErrors() throws {
        XCTAssertNotNil(EncodingError.noData.localizedDescription)
        XCTAssertNotNil(EncodingError.encodingFailed.localizedDescription)
    }
}
