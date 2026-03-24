//
//   ResultTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct ResultTests {
    @Test func `url creation`() {
        let result = getResult()
        switch result {
        case .success:
            // Do nothing
            break

        case .failure:
            Issue.record("Result should not be a failure")
        }
    }

    private func getResult() -> Result<Void, Error> {
        .success
    }
}
