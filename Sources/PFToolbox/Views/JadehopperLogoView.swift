//
//   JadehopperLogoView.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

#if canImport(SwiftUI)
import SwiftUI

/// The Jadehopper logo, drawn as a `Shape` so it honors the inherited foreground style.
///
/// ```swift
/// JadehopperLogoView()
///     .foregroundStyle(.tertiary)
/// ```
public struct JadehopperLogoView: View {
    @Environment(\.sizeCategory) private var sizeCategory

    public init() {}

    public var body: some View {
        JadehopperLogoShape()
            .frame(
                width: 28 * JadehopperLogoShape.blockSize,
                height: 14 * JadehopperLogoShape.blockSize
            )
            .padding([.vertical, .trailing], 2)
            .padding(.leading, 8)
            .scaleEffect(logoScale)
    }

    /// Defines the scaling of the logo based on the current size category
    private var logoScale: CGFloat {
        switch sizeCategory {
        case .extraSmall, .small, .medium:
            1.0
        case .large:
            1.1
        case .extraLarge:
            1.2
        case .extraExtraLarge:
            1.3
        case .extraExtraExtraLarge:
            1.4
        case .accessibilityMedium:
            1.6
        case .accessibilityLarge:
            1.8
        case .accessibilityExtraLarge:
            2.0
        case .accessibilityExtraExtraLarge:
            2.2
        case .accessibilityExtraExtraExtraLarge:
            2.4
        @unknown default:
            1.0
        }
    }
}

private struct JadehopperLogoShape: Shape {
    static let blockSize: CGFloat = 2
    private static let columns = 19
    private static let rows = 9
    private static let padding: CGFloat = 1
    private static let matrix: [Int] = [
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

    func path(in _: CGRect) -> Path {
        var path = Path()
        var index = 0
        for column in 0 ..< Self.columns {
            for row in 0 ..< Self.rows {
                if Self.matrix[index] == 1 {
                    let x = CGFloat(column) * (Self.blockSize + Self.padding)
                    let y = CGFloat(row) * (Self.blockSize + Self.padding)
                    path.addRect(
                        CGRect(
                            x: x,
                            y: y,
                            width: Self.blockSize,
                            height: Self.blockSize
                        )
                    )
                }
                index += 1
            }
        }
        return path
    }
}

#Preview {
    VStack(spacing: 16) {
        JadehopperLogoView()

        JadehopperLogoView()
            .foregroundStyle(.tertiary)

        ForEach(ContentSizeCategory.allCases, id: \.self) {
            JadehopperLogoView()
                .foregroundStyle(.purple)
                .environment(\.sizeCategory, $0)
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.gray.opacity(0.25))
}
#endif
