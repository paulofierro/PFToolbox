//
//   CGFloatTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import CoreGraphics
@testable import PFToolbox
import Testing

struct CGFloatTests {
    @Test func `degrees to radians`() {
        let value: CGFloat = 180
        #expect(value.degreesToRadians() == CGFloat.pi)
    }
}
