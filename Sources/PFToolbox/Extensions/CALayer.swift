//
//   CALayer.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

import QuartzCore

public extension CALayer {
    func removeAllSublayers() {
        sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
    }
}
