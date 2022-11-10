//
//   NSColorTests.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

#if canImport(AppKit)
    import AppKit

    final class NSColorTests: XCTestCase {
        func testAlpha() {
            let red: NSColor = .red
            let transparentRed: NSColor = .red.withAlphaComponent(0.5)

            XCTAssertEqual(red.alpha, 1.0)
            XCTAssertEqual(transparentRed.alpha, 0.5)
        }

        func testRandomColor() {
            let color = NSColor.randomColor
            XCTAssertNotNil(color)
        }
    }
#endif
