//
//   NSColorTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

#if canImport(AppKit)
import AppKit

struct NSColorTests {
    @Test func alpha() {
        let red: NSColor = .red
        let transparentRed: NSColor = .red.withAlphaComponent(0.5)

        #expect(red.alpha == 1.0)
        #expect(transparentRed.alpha == 0.5)
    }

    @Test func `random color`() {
        let color = NSColor.randomColor
        #expect(color.alphaComponent > 0)
    }
}
#endif
