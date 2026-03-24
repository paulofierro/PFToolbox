//
//   ErrorTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

struct ErrorTests {
    let url = URL.from(string: "http://paulofierro.com")

    @Test func `comparing decoding error`() {
        #expect(DecodingError.fileNotFound("abc.json") == DecodingError.fileNotFound("abc.json"))
    }

    @Test func `comparing encoding error`() {
        #expect(EncodingError.noData == EncodingError.noData)
        #expect(EncodingError.noData != EncodingError.encodingFailed)
    }
}
