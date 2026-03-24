//
//   View+HoverHighlight.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import SwiftUI

public extension View {
    /// visionOS: adds a rounded rectangle interaction and hover effect
    /// tvOS: Adds a hover effect
    /// Other: No-op
    @ViewBuilder
    @available(iOS 13, macOS 12, visionOS 1, tvOS 18, *)
    func roundedRectangleHoverEffect(cornerRadius: CGFloat = 10) -> some View {
        #if os(visionOS)
        contentShape(.interaction, RoundedRectangle(cornerRadius: cornerRadius))
            .contentShape(.hoverEffect, RoundedRectangle(cornerRadius: cornerRadius))
            .hoverEffect(.highlight)
        #elseif os(tvOS)
        hoverEffect(.highlight)
        #else
        self
        #endif
    }
}
