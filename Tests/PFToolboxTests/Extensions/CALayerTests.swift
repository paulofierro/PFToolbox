//
//   CALayerTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import QuartzCore
import Testing

struct CALayerTests {
    @Test func removingSublayers() {
        let layer = CALayer()
        layer.addSublayer(CALayer())
        layer.addSublayer(CALayer())

        #expect(layer.sublayers?.count == 2)
        layer.removeAllSublayers()
        #expect(layer.sublayers.isEmptyOrNil)
    }
}
