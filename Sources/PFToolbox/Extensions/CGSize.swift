//
//  CGSize.swift
//  
//
//  Created by Paulo Fierro.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public extension CGSize {

    var isLandscape: Bool {
        width > height
    }
    
    var isSquare: Bool {
        width == height
    }

    var isPortrait: Bool {
        !isLandscape
    }
}
