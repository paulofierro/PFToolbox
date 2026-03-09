//
//   GlobalsTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct GlobalsTests {
    @Test func isShowingPreviewTest() {
        #expect(!isShowingPreview())
    }
}
