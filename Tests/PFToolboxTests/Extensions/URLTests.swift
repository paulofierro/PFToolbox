//
//   URLTests.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class URLTests: XCTestCase {
    func testURLCreation() {
        let valid = URL.from(string: "https://paulofierro.com")
        XCTAssertNotNil(valid)

        expectFatalError(
            expectedMessage: "Could not create URL from ",
            testcase: {
                _ = URL.from(string: "")
            }
        )
    }
}
