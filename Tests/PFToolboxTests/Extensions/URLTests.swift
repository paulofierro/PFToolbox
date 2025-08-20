//
//   URLTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import CwlPreconditionTesting
@testable import PFToolbox
import XCTest

final class URLTests: XCTestCase {
    func testURLCreation() {
        let valid = URL.from(string: "https://paulofierro.com")
        XCTAssertNotNil(valid)

        let exception = catchBadInstruction {
            _ = URL.from(string: "")
        }
        XCTAssertNotNil(exception)
    }
}
