//
//   CGSize.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
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
