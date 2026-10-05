//
//   View+Modify.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

#if canImport(SwiftUI)
import SwiftUI

public extension View {
    /// Allows for inline modification of views
    /// Lets you do things like:
    ///     ```.modify {
    ///         if #available(watchOS 7, *) {
    ///             $0.textCase(.uppercase)
    ///         } else {
    ///             $0 // watchOS 6 fallback
    ///         }
    ///     }```
    /// Source: https://blog.overdesigned.net/posts/2020-09-23-swiftui-availability/
    func modify(@ViewBuilder _ modifier: (Self) -> some View) -> some View {
        modifier(self)
    }
}

public extension ToolbarContent {
    /// Allows for inline modification of toolbar content, mirroring
    /// `View.modify` so availability checks can be applied
    /// to individual toolbar items.
    func modify(@ToolbarContentBuilder _ modifier: (Self) -> some ToolbarContent) -> some ToolbarContent {
        modifier(self)
    }
}

#endif
