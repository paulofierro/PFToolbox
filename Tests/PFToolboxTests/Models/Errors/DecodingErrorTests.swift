//
//   DecodingErrorTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct DecodingErrorTests {
    @Test func localizedErrors() {
        let error: DecodingError = .fileNotFound("readme.txt")
        #expect(error.localizedDescription == "File not found: readme.txt")
    }
}
