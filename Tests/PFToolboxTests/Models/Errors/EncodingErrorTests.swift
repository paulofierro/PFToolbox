//
//   EncodingErrorTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class EncodingErrorTests: XCTestCase {
    func testLocalizedErrors() {
        XCTAssertNotNil(EncodingError.noData.localizedDescription)
        XCTAssertNotNil(EncodingError.encodingFailed.localizedDescription)
    }
}
