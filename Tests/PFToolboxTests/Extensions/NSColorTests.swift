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
        #expect(NSColor.clear.alpha == 0.0)
    }

    /// Catalog and dynamic system colors live outside an RGB color space, where
    /// `getRed(_:green:blue:alpha:)` raises rather than returning a value.
    @Test func `alpha for colors outside an RGB color space`() {
        #expect(NSColor.labelColor.type == .catalog)
        #expect(NSColor.labelColor.alpha > 0)

        let pattern = NSColor(patternImage: NSImage(size: NSSize(width: 4, height: 4)))
        #expect(pattern.type == .pattern)
        #expect(pattern.alpha == 1.0)
    }

    @Test func `random color`() {
        let color = NSColor.randomColor
        #expect(color.alphaComponent == 1.0)
    }

    /// The hue should cover the full range, and saturation and brightness should stay
    /// in the upper half so the color is neither washed out nor near-black.
    @Test func `random color spread`() {
        var hues: [CGFloat] = []

        for _ in 0 ..< 50 {
            let color = NSColor.randomColor
            hues.append(color.hueComponent)

            #expect(color.saturationComponent >= 0.5)
            #expect(color.saturationComponent <= 1.0)
            #expect(color.brightnessComponent >= 0.5)
            #expect(color.brightnessComponent <= 1.0)
        }

        // Uniform hues over 50 samples land above the midpoint with near-certainty
        #expect(hues.contains { $0 > 0.5 })
    }
}
#endif
