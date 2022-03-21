//
//  CGSize.swift
//  
//
//  Created by Paulo Fierro.
//

import CoreGraphics

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
