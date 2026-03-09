//
//   CGSizeTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import CoreGraphics
@testable import PFToolbox
import Testing

struct CGSizeTests {
    @Test func orientation() {
        let square = CGSize(width: 100, height: 100)
        let landscape = CGSize(width: 200, height: 100)
        let portrait = CGSize(width: 100, height: 200)

        #expect(square.isSquare)
        #expect(landscape.isLandscape)
        #expect(portrait.isPortrait)
    }
}
