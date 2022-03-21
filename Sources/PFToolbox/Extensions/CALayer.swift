//
//  CALayer.swift
//  
//
//  Created by Paulo Fierro.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public extension CALayer {

    func removeAllSublayers() {
        sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
    }
}
