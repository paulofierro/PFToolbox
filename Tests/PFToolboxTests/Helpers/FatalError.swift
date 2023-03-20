//
//   FatalError.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

// Modified from https://stackoverflow.com/questions/32873212/unit-test-fatalerror-in-swift
extension XCTestCase {
    func expectFatalError(expectedMessage: String, testcase: @escaping () -> Void) {
        let expectation = expectation(description: "expectingFatalError")
        var assertionMessage: String?

        // Override fatalError
        // This will pause forever when fatalError is called.
        FatalErrorUtil.replaceFatalError { message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            unreachable()
        }

        // Call on a separate thread because a call to fatalError pauses forever
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)

        waitForExpectations(timeout: 0.1) { _ in
            XCTAssertEqual(assertionMessage, expectedMessage)
            // Clean up
            FatalErrorUtil.restoreFatalError()
        }
    }
}
