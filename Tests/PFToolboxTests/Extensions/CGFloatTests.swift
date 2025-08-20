//
//   CGFloatTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class CGFloatTests: XCTestCase {
    func testDegreesToRadians() {
        let value: CGFloat = 180
        XCTAssertEqual(value.degreesToRadians(), Double.pi)
    }
}
