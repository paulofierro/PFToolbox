//
//   CGFloatTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

#if canImport(CoreGraphics)
import CoreGraphics

struct CGFloatTests {
    @Test func `degrees to radians`() {
        let value: CGFloat = 180
        #expect(value.degreesToRadians() == CGFloat.pi)
    }
}
#endif
