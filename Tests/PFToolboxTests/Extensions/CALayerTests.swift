//
//   CALayerTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

#if canImport(QuartzCore)
import QuartzCore

struct CALayerTests {
    @Test func `removing sublayers`() {
        let layer = CALayer()
        layer.addSublayer(CALayer())
        layer.addSublayer(CALayer())

        #expect(layer.sublayers?.count == 2)
        layer.removeAllSublayers()
        #expect(layer.sublayers.isEmptyOrNil)
    }
}
#endif
