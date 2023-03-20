//
//   FatalErrorTests.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class FatalErrorTests: XCTestCase {
    func testFatalError() throws {
        let message = "Something bad happened"
        expectFatalError(
            expectedMessage: message,
            testcase: {
                fatalError(message)
            }
        )
    }
}
