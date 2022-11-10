//
//   UIColorTests.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

#if canImport(UIKit)
    import UIKit

    final class UIColorTests: XCTestCase {
        func testAlpha() {
            let red: UIColor = .red
            let transparentRed: UIColor = .red.withAlphaComponent(0.5)

            XCTAssertEqual(red.alpha, 1.0)
            XCTAssertEqual(transparentRed.alpha, 0.5)
        }

        func testRandomColor() {
            let color = UIColor.randomColor
            XCTAssertNotNil(color)
        }
    }
#endif
