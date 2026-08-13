//
//   DeviceTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct DeviceTests {
    /// Exactly one idiom can be true at a time, whichever platform the suite runs on
    @Test func `reports a single idiom`() {
        let idioms = [
            Device.isPhone(),
            Device.isIpad(),
            Device.isTV(),
            Device.isCarPlay(),
            Device.isMac(),
            Device.isVision()
        ]
        #expect(idioms.filter(\.self).count == 1)
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
        #endif
    }
}
