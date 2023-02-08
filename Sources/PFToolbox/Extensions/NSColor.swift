//
//   NSColor.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

#if canImport(AppKit)
    import AppKit

    public extension NSColor {
        /// Returns alpha value in range 0.0...1.0
        var alpha: Float {
            var alpha: CGFloat = 0
            getRed(nil, green: nil, blue: nil, alpha: &alpha)
            return Float(alpha)
        }

        /// Returns a random color
        static var randomColor: NSColor {
            NSColor(
                calibratedHue: CGFloat.random(in: 0 ... 1) / 256, // Full range from 0.0 to 1.0
                saturation: CGFloat.random(in: 0 ... 0.5) / 256 + 0.5, // From 0.5 to 1.0 to avoid white
                brightness: CGFloat.random(in: 0 ... 0.5) / 256 + 0.5, // From 0.5 to 1.0 to avoid black
                alpha: 1
            )
        }
    }
#endif
