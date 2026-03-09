//
//   GenericErrorTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class GenericErrorTests: XCTestCase {
    func testLocalizedErrors() {
        let message = "Something happened"
        let error: GenericError = .custom(message)
        XCTAssertEqual(error.localizedDescription, message)
    }

    func testEquality() {
        let message = "Something bad happened"
        let error: GenericError = .custom(message)
        XCTAssertEqual(error, GenericError.custom(message))
    }
}
