//
//   ViewTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

#if canImport(AppKit)
import AppKit

@MainActor
struct NSViewTests {
    @Test func `pinning edges activates four constraints`() {
        let container = NSView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
        let view = NSView()
        container.addSubview(view)

        view.pinEdges(to: container)

        #expect(view.translatesAutoresizingMaskIntoConstraints == false)
        #expect(container.constraints.count == 4)
    }

    @Test func `pinning edges applies insets`() {
        let container = NSView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
        let view = NSView()
        container.addSubview(view)

        let insets = NSEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        view.pinEdges(to: container, with: insets)

        let constants = container.constraints.map(\.constant).sorted()
        #expect(constants == [1, 2, 3, 4])
    }
}
#endif

#if canImport(UIKit)
import UIKit

@MainActor
struct UIViewTests {
    @Test func `pinning edges activates four constraints`() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let view = UIView()
        container.addSubview(view)

        view.pinEdges(to: container)

        #expect(view.translatesAutoresizingMaskIntoConstraints == false)
        #expect(container.constraints.count == 4)
    }

    @Test func `pinning edges applies insets`() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let view = UIView()
        container.addSubview(view)

        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        view.pinEdges(to: container, with: insets)

        let constants = container.constraints.map(\.constant).sorted()
        #expect(constants == [1, 2, 3, 4])
    }

    @Test func `rendering a view to an image preserves its size`() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        let image = view.toImage()
        #expect(image.size == CGSize(width: 30, height: 20))
    }

    @Test func `should animate tracks reduce motion`() {
        #expect(UIView.shouldAnimate == !UIAccessibility.isReduceMotionEnabled)
    }
}
#endif
