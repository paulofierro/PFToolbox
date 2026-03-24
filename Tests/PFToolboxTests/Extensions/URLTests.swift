//
//   URLTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import CwlPreconditionTesting
import Foundation
@testable import PFToolbox
import Testing

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
