//
//   GlobalsTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class GlobalsTests: XCTestCase {
    func testisShowingPreview() {
        XCTAssertFalse(isShowingPreview())
    }
}
