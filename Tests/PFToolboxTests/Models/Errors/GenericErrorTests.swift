//
//   GenericErrorTests.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class GenericErrorTests: XCTestCase {
    func testLocalizedErrors() throws {
        let message = "Something happened"
        let error: GenericError = .custom(message)
        XCTAssertEqual(error.localizedDescription, message)
    }

    func testEquality() throws {
        let message = "Something bad happened"
        let error: GenericError = .custom(message)
        XCTAssertEqual(error, GenericError.custom(message))
    }
}
