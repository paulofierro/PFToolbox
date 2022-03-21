//
//  CALayer.swift
//  
//
//  Created by Paulo Fierro.
//

import QuartzCore

public extension CALayer {

    func removeAllSublayers() {
        sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
    }
}
