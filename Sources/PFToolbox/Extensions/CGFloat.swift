//
//   CGFloat.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

#if canImport(CoreGraphics)
import CoreGraphics
import Foundation

public extension CGFloat {
    func degreesToRadians() -> CGFloat {
        Measurement(value: self, unit: UnitAngle.degrees)
            .converted(to: .radians)
            .value
    }
}
#endif
