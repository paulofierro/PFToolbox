//
//   URLTests.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class URLTests: XCTestCase {
    func testURLCreation() {
        let url = URL.from(string: "https://paulofierro.com")
        XCTAssertNotNil(url)
    }
}
