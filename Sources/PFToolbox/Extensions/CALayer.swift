//
//   CALayer.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import QuartzCore

public extension CALayer {
    func removeAllSublayers() {
        sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
    }
}
