//
//  CGFloat.swift
//  
//
//  Created by Paulo Fierro.
//

import CoreGraphics
import Foundation

public extension CGFloat {

    func degreesToRadians() -> CGFloat {
        Measurement(value: self, unit: UnitAngle.degrees)
            .converted(to: .radians)
            .value
    }
}
