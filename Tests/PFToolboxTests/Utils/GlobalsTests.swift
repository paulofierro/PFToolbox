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

    /// True by definition here, whichever runner is hosting the suite. The executable is
    /// reported so that a failure on an unfamiliar host names the process it did not recognise.
    @Test func `is running tests`() {
        let executable = ProcessInfo.processInfo.arguments.first ?? "<none>"
        #expect(isRunningTests(), "Unrecognised test runner: \(executable)")
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
