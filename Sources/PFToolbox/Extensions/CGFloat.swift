//
//  CGFloat.swift
//  
//
//  Created by Paulo Fierro.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public extension CGFloat {

    func degreesToRadians() -> CGFloat {
        CGFloat(Double(self) * Double.pi / 180.0)
    }
}
