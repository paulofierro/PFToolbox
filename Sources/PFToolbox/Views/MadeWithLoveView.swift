//
//   MadeWithLoveView.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import SwiftUI

/// A view that displays "made with ♥️ in Cayman" with a pulsing heartbeat animation on the heart.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, visionOS 1.0, *)
public struct MadeWithLoveView: View {
    @State private var heartScale: CGFloat = 1.0

    public let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

    public var body: some View {
        HStack(spacing: 4) {
            Text("made with")
            Text("♥️")
                .scaleEffect(heartScale)
                .padding(.horizontal, -2)
            Text("in Cayman")
        }
        .task {
            guard animated else { return }
            await heartbeat()
        }
    }

    /// Runs a repeating heartbeat animation: two quick pulses (lub-dub) followed by a pause.
    private func heartbeat() async {
        let beatUp: UInt64 = 250_000_000
        let beatDown: UInt64 = 250_000_000
        let pause: UInt64 = 5_000_000_000

        while !Task.isCancelled {
            // First beat (lub)
            withAnimation(.easeIn(duration: 0.25)) {
                heartScale = 1.3
            }
            try? await Task.sleep(nanoseconds: beatUp)

            withAnimation(.easeOut(duration: 0.25)) {
                heartScale = 1.0
            }
            try? await Task.sleep(nanoseconds: beatDown)

            // Second beat (dub)
            withAnimation(.easeIn(duration: 0.25)) {
                heartScale = 1.2
            }
            try? await Task.sleep(nanoseconds: beatUp)

            withAnimation(.easeOut(duration: 0.25)) {
                heartScale = 1.0
            }
            try? await Task.sleep(nanoseconds: beatDown)

            // Pause between heartbeats
            try? await Task.sleep(nanoseconds: pause)
        }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, visionOS 1.0, *)
#Preview {
    VStack(spacing: 16) {
        MadeWithLoveView()
            .foregroundStyle(.secondary)

        MadeWithLoveView(animated: false)
    }
    .frame(
        maxWidth: .infinity,
        maxHeight: .infinity
    )
    .background(.gray.opacity(0.25))
}
