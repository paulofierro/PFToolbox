//
//   CGSize.swift
//   Copyright © Paulo Fierro. All rights reserved.
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
        height > width
    }
}
