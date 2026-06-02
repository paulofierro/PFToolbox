//
//   MadeWithLoveView.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

#if canImport(SwiftUI)
import SwiftUI

/// A view that displays "made with ♥️ in Cayman" with a pulsing heartbeat animation on the heart.
public struct MadeWithLoveView: View {
    @State private var heartScale: Double = 1.0

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
                .accessibilityHidden(true)
            Text("in Cayman")
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Made with love in Cayman")
        .task {
            guard animated else { return }
            await heartbeat()
        }
    }

    /// Runs a repeating heartbeat animation: two quick pulses (lub-dub) followed by a pause.
    private func heartbeat() async {
        let beat: TimeInterval = 0.25
        let pause: TimeInterval = 5
        let beatAnimation: Animation = .easeIn(duration: beat)
        let releaseAnimation: Animation = .easeOut(duration: beat)

        while !Task.isCancelled {
            // First beat (lub)
            withAnimation(beatAnimation) { heartScale = 1.3 }
            try? await Task.sleep(for: .seconds(beat))

            withAnimation(releaseAnimation) { heartScale = 1.0 }
            try? await Task.sleep(for: .seconds(beat))

            // Second beat (dub)
            withAnimation(beatAnimation) { heartScale = 1.2 }
            try? await Task.sleep(for: .seconds(beat))

            withAnimation(releaseAnimation) { heartScale = 1.0 }
            try? await Task.sleep(for: .seconds(beat))

            // Pause between heartbeats
            try? await Task.sleep(for: .seconds(pause))
        }
    }
}

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
#endif
