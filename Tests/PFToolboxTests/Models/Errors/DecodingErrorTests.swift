//
//   DecodingErrorTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct DecodingErrorTests {
    @Test func `localized errors`() {
        let error: DecodingError = .fileNotFound("readme.txt")
        #expect(error.localizedDescription == "File not found: readme.txt")
    }
}
