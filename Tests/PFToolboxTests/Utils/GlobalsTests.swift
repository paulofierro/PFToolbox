//
//   GlobalsTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

struct GlobalsTests {
    @Test func `is showing preview test`() {
        #expect(!isShowingPreview())
    }

    /// The suite is running under XCTest by definition
    @Test func `is running tests`() {
        #expect(isRunningTests())
    }

    @Test func `is running on CI`() {
        let expected = ProcessInfo.processInfo.environment["CI"] == "true"
        #expect(isRunningOnCI() == expected)
    }

    @Test func `global logger identity`() {
        #expect(log.subsystem == "com.paulofierro.PFToolbox")
        #expect(log.category == "PFToolbox")
    }
}
