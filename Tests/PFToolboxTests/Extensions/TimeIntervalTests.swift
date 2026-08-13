//
//   TimeIntervalTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

struct TimeIntervalTests {
    @Test func `default animation duration`() {
        #expect(TimeInterval.defaultAnimationDuration == 0.4)
    }
}
