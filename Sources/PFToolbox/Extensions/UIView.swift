//
//   UIView.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

#if canImport(UIKit)
    import UIKit

    public extension UIView {
        /// Checks if Reduce Motion is enabled, and otherwise returns true
        static var shouldAnimate: Bool {
            !UIAccessibility.isReduceMotionEnabled
        }

        /// Pins the edges of the view to a container with optional insets.
        func pinEdges(to container: UIView, with insets: UIEdgeInsets = .zero) {
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: insets.left),
                trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: insets.right),
                topAnchor.constraint(equalTo: container.topAnchor, constant: insets.top),
                bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: insets.bottom)
            ])
        }

        /// Returns the view as an image
        func toImage() -> UIImage {
            let renderer = UIGraphicsImageRenderer(size: bounds.size)
            let image = renderer.image { _ in
                drawHierarchy(in: bounds, afterScreenUpdates: true)
            }
            return image
        }
    }
#endif
