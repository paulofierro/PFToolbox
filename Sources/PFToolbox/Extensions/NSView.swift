//
//   NSView.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

#if canImport(AppKit)
    import AppKit

    public extension NSView {
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
        func loadNib(in bundle: Bundle? = nil) {
            let className = "\(Self.self)"
            let nibBundle = bundle ?? Bundle.main
            let nib = NSNib(
                nibNamed: NSNib.Name(className),
                bundle: nibBundle
            )
            nib?.instantiate(withOwner: self, topLevelObjects: nil)
        }
    }
#endif
