//
//   NetworkErrorTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct NetworkErrorTests {
    @Test func equality() {
        #expect(NetworkError.authenticationError(400).localizedDescription == "authenticationError(400)")
        #expect(NetworkError.serverError(300).localizedDescription == "serverError(300)")
        #expect(NetworkError.failed(404).localizedDescription == "failed(404)")
        #expect(NetworkError.noData(400).localizedDescription == "noData(400)")
        #expect(NetworkError.outdated(422).localizedDescription == "outdated(422)")
        #expect(NetworkError.notFound(404).localizedDescription == "notFound(404)")
        #expect(NetworkError.badResponse(500).localizedDescription == "badResponse(500)")
        #expect(NetworkError.invalidResponse.localizedDescription == "invalidResponse")
    }
}
