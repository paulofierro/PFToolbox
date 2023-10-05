//
//   URLTests.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import CwlPreconditionTesting
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
