//
//   JadehopperLogoView.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

#if canImport(SwiftUI)
import SwiftUI

/// The Jadehopper logo drawn in a Canvas
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct JadehopperLogoView: View {
    /// The current size category
    @Environment(\.sizeCategory) var sizeCategory

    private let columns: Int = 19
    private let rows: Int = 9
    private let padding: CGFloat = 1
    private let blockSize: CGFloat = 2
    private let matrix = [
        0, 0, 0, 0, 1, 0, 1, 0, 0,
        0, 0, 0, 1, 1, 1, 1, 0, 1,
        0, 0, 0, 1, 1, 1, 1, 1, 0,
        0, 0, 0, 1, 1, 1, 1, 0, 0,
        0, 0, 1, 1, 1, 1, 1, 0, 0,
        0, 1, 1, 1, 1, 1, 1, 0, 0,
        0, 0, 1, 1, 1, 1, 1, 1, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 0,
        0, 0, 0, 1, 1, 1, 1, 0, 0,
        0, 0, 0, 1, 1, 1, 1, 0, 0,
        0, 0, 0, 1, 1, 1, 1, 0, 0,
        0, 0, 0, 1, 1, 1, 1, 0, 1,
        0, 0, 0, 1, 1, 1, 1, 1, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 0,
        0, 0, 1, 1, 0, 1, 1, 0, 1,
        0, 1, 0, 1, 1, 1, 0, 0, 0,
        1, 0, 1, 0, 0, 0, 0, 0, 0,
        0, 1, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0, 0
    ]

    private var blocks: [CGRect] = []

    public let color: Color

    public init(color: Color) {
        self.color = color

        // Build the array of rects to draw the squares
        var index = 0
        for column in 0 ... columns - 1 {
            for row in 0 ... rows - 1 {
                if matrix[index] == 1 {
                    let column = CGFloat(column)
                    let row = CGFloat(row)

                    let rect = CGRect(
                        x: column * blockSize + column * padding,
                        y: row * blockSize + row * padding,
                        width: blockSize,
                        height: blockSize
                    )
                    blocks.append(rect)
                }
                index += 1
            }
        }
    }

    public var body: some View {
        Canvas { context, _ in
            for rect in blocks {
                context.fill(Path(rect), with: .color(color))
            }
        }
        .frame(
            width: 28 * blockSize,
            height: 14 * blockSize
        )
        .padding([.vertical, .trailing], 2)
        .padding(.leading, 8)
        .scaleEffect(logoScale)
    }

    /// Defines the scaling of the logo based on the current size category
    private var logoScale: CGFloat {
        switch sizeCategory {
        case .extraSmall, .small, .medium:
            return 1.0
        case .large:
            return 1.1
        case .extraLarge:
            return 1.2
        case .extraExtraLarge:
            return 1.3
        case .extraExtraExtraLarge:
            return 1.4
        case .accessibilityMedium:
            return 1.6
        case .accessibilityLarge:
            return 1.8
        case .accessibilityExtraLarge:
            return 2.0
        case .accessibilityExtraExtraLarge:
            return 2.2
        case .accessibilityExtraExtraExtraLarge:
            return 2.4
        @unknown default:
            return 1.0
        }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
#Preview {
    VStack {
        Text("This is text")
        JadehopperLogoView(color: .purple)
            .background(.red)
    }
    .frame(
        maxWidth: .infinity,
        maxHeight: .infinity
    )
    .background(.gray.opacity(0.25))
}
#endif
