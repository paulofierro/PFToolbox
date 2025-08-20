//
//   ArrayTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class ArrayTests: XCTestCase {
    func testSafeIndex() {
        let array = [1, 2, 3]

        XCTAssertEqual(array[0], 1)
        XCTAssertEqual(array[safeIndex: 0], 1)

        XCTAssertEqual(array[1], 2)
        XCTAssertEqual(array[safeIndex: 1], 2)

        XCTAssertEqual(array[2], 3)
        XCTAssertEqual(array[safeIndex: 2], 3)

        // Out of bounds exception
        XCTAssertNil(array[safeIndex: 3])
    }
}
