//
//   GenericErrorTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct GenericErrorTests {
    @Test func `localized errors`() {
        let message = "Something happened"
        let error: GenericError = .custom(message)
        #expect(error.localizedDescription == message)
    }

    @Test func equality() {
        let message = "Something bad happened"
        let error: GenericError = .custom(message)
        #expect(error == GenericError.custom(message))
    }
}
