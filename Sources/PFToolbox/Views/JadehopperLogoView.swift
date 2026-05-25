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
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

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

    /// Defines the scaling of the logo based on the current Dynamic Type size.
    private var logoScale: Double {
        switch dynamicTypeSize {
        case .xSmall, .small, .medium:
            1.0
        case .large:
            1.1
        case .xLarge:
            1.2
        case .xxLarge:
            1.3
        case .xxxLarge:
            1.4
        case .accessibility1:
            1.6
        case .accessibility2:
            1.8
        case .accessibility3:
            2.0
        case .accessibility4:
            2.2
        case .accessibility5:
            2.4
        @unknown default:
            1.0
        }
    }
}

private struct JadehopperLogoShape: Shape {
    static let blockSize: Double = 2
    private static let columns = 19
    private static let rows = 9
    private static let padding: Double = 1
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
                    let x = Double(column) * (Self.blockSize + Self.padding)
                    let y = Double(row) * (Self.blockSize + Self.padding)
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

        ForEach(DynamicTypeSize.allCases, id: \.self) {
            JadehopperLogoView()
                .foregroundStyle(.purple)
                .dynamicTypeSize($0)
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.gray.opacity(0.25))
}
#endif
