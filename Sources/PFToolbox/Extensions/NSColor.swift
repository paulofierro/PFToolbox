//
//   NSColor.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

#if canImport(AppKit)
import AppKit

public extension NSColor {
    /// Returns alpha value in range 0.0...1.0
    ///
    /// Reads the resolved `cgColor` rather than `getRed(_:green:blue:alpha:)`, which raises for
    /// colors outside an RGB color space such as catalog and dynamic system colors.
    var alpha: Float {
        Float(cgColor.alpha)
    }

    /// Returns a random color
    static var randomColor: NSColor {
        NSColor(
            calibratedHue: CGFloat.random(in: 0 ... 1), // Full range from 0.0 to 1.0
            saturation: CGFloat.random(in: 0.5 ... 1), // From 0.5 to 1.0 to avoid white
            brightness: CGFloat.random(in: 0.5 ... 1), // From 0.5 to 1.0 to avoid black
            alpha: 1
        )
    }
}
#endif
