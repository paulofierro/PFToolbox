//
//   NSView.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

#if canImport(AppKit)
    import AppKit

    public extension NSView {
        /// The default duration to use for animations
        static let defaultAnimationDuration: TimeInterval = 0.4

        /// Pins the edges of the view to a container with optional insets.
        func pinEdges(to container: NSView, with insets: NSEdgeInsets = .init()) {
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: insets.left),
                trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: insets.right),
                topAnchor.constraint(equalTo: container.topAnchor, constant: insets.top),
                bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: insets.bottom)
            ])
        }

        /// Loads a .xib file from the same bundle as the view, and instantiates it
        func loadNib() {
            let type = type(of: self)
            let nib = NSNib(
                nibNamed: String(describing: type),
                bundle: Bundle(for: type)
            )
            nib?.instantiate(withOwner: self, topLevelObjects: nil)
        }
    }
#endif
