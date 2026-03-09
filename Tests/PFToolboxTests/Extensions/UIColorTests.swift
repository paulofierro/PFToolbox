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
        }

        @Test func randomColor() {
            let color = UIColor.randomColor
            #expect(color != nil)
        }
    }
#endif
