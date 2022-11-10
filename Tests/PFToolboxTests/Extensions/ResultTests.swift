//
//   ResultTests.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class ResultTests: XCTestCase {
    func testURLCreation() {
        let result = getResult()
        switch result {
        case .success:
            // Do nothing
            break

        case .failure:
            XCTFail("Result should not be a failure")
        }
    }

    private func getResult() -> Result<Void, Error> {
        .success
    }
}
