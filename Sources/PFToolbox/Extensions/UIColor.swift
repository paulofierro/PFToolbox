//
//   UIColor.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// Returns alpha value in range 0.0...1.0
    ///
    /// Reads the resolved `cgColor` rather than `getRed(_:green:blue:alpha:)`, which returns
    /// `false` without writing a value for colors outside an RGB color space.
    var alpha: Float {
        Float(cgColor.alpha)
    }

    /// Returns a random color
    static var randomColor: UIColor {
        UIColor(
            hue: CGFloat.random(in: 0 ... 1), // Full range from 0.0 to 1.0
            saturation: CGFloat.random(in: 0.5 ... 1), // From 0.5 to 1.0 to avoid white
            brightness: CGFloat.random(in: 0.5 ... 1), // From 0.5 to 1.0 to avoid black
            alpha: 1
        )
    }
}
#endif
