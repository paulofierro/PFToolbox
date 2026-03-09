//
//   CGFloatTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import CoreGraphics
@testable import PFToolbox
import Testing

struct CGFloatTests {
    @Test func degreesToRadians() {
        let value: CGFloat = 180
        #expect(value.degreesToRadians() == CGFloat.pi)
    }
}
