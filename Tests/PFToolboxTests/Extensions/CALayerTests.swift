//
//   CALayerTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class CALayerTests: XCTestCase {
    func testRemovingSublayers() {
        let layer = CALayer()
        layer.addSublayer(CALayer())
        layer.addSublayer(CALayer())

        XCTAssertEqual(layer.sublayers?.count, 2)
        layer.removeAllSublayers()
        XCTAssertTrue(layer.sublayers.isEmptyOrNil)
    }
}
