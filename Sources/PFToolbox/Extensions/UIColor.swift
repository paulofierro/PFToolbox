//
//   UIColor.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

#if canImport(UIKit)
    import UIKit

    public extension UIColor {
        /// Returns alpha value in range 0.0...1.0
        var alpha: Float {
            var alpha: CGFloat = 0
            getRed(nil, green: nil, blue: nil, alpha: &alpha)
            return Float(alpha)
        }

        /// Returns a random color
        static var randomColor: UIColor {
            UIColor(
                hue: CGFloat.random(in: 0 ... 1), // Full range from 0.0 to 1.0
                saturation: CGFloat.random(in: 0 ... 0.5) + 0.5, // From 0.5 to 1.0 to avoid white
                brightness: CGFloat.random(in: 0 ... 0.5) + 0.5, // From 0.5 to 1.0 to avoid black
                alpha: 1
            )
        }
    }
#endif
