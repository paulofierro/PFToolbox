//
//   UIColorTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

#if canImport(UIKit)
import UIKit

struct UIColorTests {
    @Test func alpha() {
        let red: UIColor = .red
        let transparentRed: UIColor = .red.withAlphaComponent(0.5)

        #expect(red.alpha == 1.0)
        #expect(transparentRed.alpha == 0.5)
        #expect(UIColor.clear.alpha == 0.0)
    }

    /// Pattern colors are outside an RGB color space, where `getRed(_:green:blue:alpha:)`
    /// returns `false` without writing a value.
    @Test func `alpha for colors outside an RGB color space`() {
        let size = CGSize(width: 4, height: 4)
        let image = UIGraphicsImageRenderer(size: size).image { context in
            UIColor.red.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }

        let pattern = UIColor(patternImage: image)
        #expect(pattern.alpha == 1.0)
    }

    @Test func `random color`() {
        var alpha: CGFloat = 0
        let color = UIColor.randomColor

        #expect(color.getRed(nil, green: nil, blue: nil, alpha: &alpha))
        #expect(alpha == 1.0)
    }

    /// The hue should cover the full range, and saturation and brightness should stay
    /// in the upper half so the color is neither washed out nor near-black.
    @Test func `random color spread`() {
        var hues: [CGFloat] = []

        for _ in 0 ..< 50 {
            var hue: CGFloat = 0
            var saturation: CGFloat = 0
            var brightness: CGFloat = 0

            let color = UIColor.randomColor
            #expect(color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil))
            hues.append(hue)

            #expect(saturation >= 0.5)
            #expect(saturation <= 1.0)
            #expect(brightness >= 0.5)
            #expect(brightness <= 1.0)
        }

        // Uniform hues over 50 samples land above the midpoint with near-certainty
        #expect(hues.contains { $0 > 0.5 })
    }
}
#endif
