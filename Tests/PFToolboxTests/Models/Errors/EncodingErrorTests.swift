//
//   EncodingErrorTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct EncodingErrorTests {
    @Test func `localized errors`() {
        #expect(EncodingError.noData.localizedDescription.isEmpty == false)
        #expect(EncodingError.encodingFailed.localizedDescription.isEmpty == false)
    }
}
