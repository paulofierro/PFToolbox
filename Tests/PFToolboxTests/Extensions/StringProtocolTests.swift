//
//   StringProtocolTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct StringProtocolTests {
    @Test func doesNotContain() {
        let string = "abc"
        #expect(!string.doesNotContain("a"))
        #expect(!string.doesNotContain("abc"))

        #expect(string.doesNotContain("e"))
        #expect(string.doesNotContain("123"))
    }
}
