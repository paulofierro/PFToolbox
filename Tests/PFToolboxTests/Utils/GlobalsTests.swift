//
//   GlobalsTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct GlobalsTests {
    @Test func `is showing preview test`() {
        #expect(!isShowingPreview())
    }
}
