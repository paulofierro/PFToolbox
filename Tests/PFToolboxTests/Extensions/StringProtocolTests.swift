//
//   StringProtocolTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class StringProtocolTests: XCTestCase {
    func testDoesNotContain() {
        let string = "abc"
        XCTAssertFalse(string.doesNotContain("a"))
        XCTAssertFalse(string.doesNotContain("abc"))

        XCTAssertTrue(string.doesNotContain("e"))
        XCTAssertTrue(string.doesNotContain("123"))
    }
}
