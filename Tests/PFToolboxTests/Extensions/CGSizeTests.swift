//
//   CGSizeTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

#if canImport(CoreGraphics)
import CoreGraphics

struct CGSizeTests {
    @Test func orientation() {
        let square = CGSize(width: 100, height: 100)
        let landscape = CGSize(width: 200, height: 100)
        let portrait = CGSize(width: 100, height: 200)

        #expect(square.isSquare)
        #expect(landscape.isSquare == false)
        #expect(portrait.isSquare == false)

        #expect(square.isLandscape == false)
        #expect(landscape.isLandscape)
        #expect(portrait.isLandscape == false)

        #expect(square.isPortrait == false)
        #expect(landscape.isPortrait == false)
        #expect(portrait.isPortrait)
    }
}
#endif
