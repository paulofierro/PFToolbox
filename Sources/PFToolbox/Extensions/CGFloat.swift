//
//  CGFloat.swift
//  
//
//  Created by Paulo Fierro.
//

import CoreGraphics

public extension CGFloat {

    func degreesToRadians() -> CGFloat {
        CGFloat(Double(self) * Double.pi / 180.0)
    }
}
