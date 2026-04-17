//
//   URLTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

#if canImport(CwlPreconditionTesting)
import CwlPreconditionTesting

struct URLTests {
    @Test func `url creation`() {
        let valid = URL.from(string: "https://paulofierro.com")
        #expect(valid.absoluteString == "https://paulofierro.com")

        let exception = catchBadInstruction {
            _ = URL.from(string: "")
        }
        #expect(exception != nil)
    }
}
#else
struct URLTests {
    @Test func `url creation`() {
        let valid = URL.from(string: "https://paulofierro.com")
        #expect(valid.absoluteString == "https://paulofierro.com")
    }
}
#endif
