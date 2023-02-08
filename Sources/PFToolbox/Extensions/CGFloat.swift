//
//   CGFloat.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
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
