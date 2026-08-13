//
//   DeviceTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct DeviceTests {
    private var idioms: [Bool] {
        [
            Device.isPhone(),
            Device.isIpad(),
            Device.isTV(),
            Device.isCarPlay(),
            Device.isMac(),
            Device.isVision()
        ]
    }

    /// The idioms are mutually exclusive. Platforms without a UI framework match none of them,
    /// which is why this is an upper bound rather than an exact count.
    @Test func `reports at most one idiom`() {
        #expect(idioms.filter(\.self).count <= 1)
    }

    @Test func `reports the idiom for the running platform`() {
        #if os(macOS)
        #expect(Device.isMac())
        #elseif os(tvOS)
        #expect(Device.isTV())
        #elseif os(visionOS)
        #expect(Device.isVision())
        #elseif os(iOS)
        #expect(Device.isPhone() || Device.isIpad() || Device.isMac())
        #else
        // Linux has neither UIKit nor AppKit, so every idiom reports false
        #expect(idioms.allSatisfy { $0 == false })
        #endif
    }
}
