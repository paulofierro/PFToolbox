//
//   LoggerTests.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class LoggerTests: XCTestCase {
    func testExistence() throws {
        let log = Logger(subsystem: "com.paulofierro.PFToolboxTests", category: "PFToolboxTests")
        XCTAssertNotNil(log)

        // Should probably test std_err output
        log.debug("debug")
        log.info("info")
        log.warn("warn")
        log.error("error")
    }
}
