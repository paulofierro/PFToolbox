//
//   LoggerTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class LoggerTests: XCTestCase {
    func testExistence() throws {
        let log = Logger(
            subsystem: "com.paulofierro.PFToolboxTests",
            category: "PFToolboxTests"
        )
        XCTAssertNotNil(log)
    }

    func testLogTypes() {
        XCTAssertEqual(Logger.LogLevel.none.logType, .default)
        XCTAssertEqual(Logger.LogLevel.error.logType, .error)
        XCTAssertEqual(Logger.LogLevel.warning.logType, .fault)
        XCTAssertEqual(Logger.LogLevel.info.logType, .info)
        XCTAssertEqual(Logger.LogLevel.debug.logType, .debug)
    }

    func testAllowedLevels() {
        XCTAssertEqual(Logger.LogLevel.none.allowedLevels, [])
        XCTAssertEqual(Logger.LogLevel.error.allowedLevels, [.error])
        XCTAssertEqual(Logger.LogLevel.warning.allowedLevels, [.error, .warning])
        XCTAssertEqual(Logger.LogLevel.info.allowedLevels, [.error, .warning, .info])
        XCTAssertEqual(Logger.LogLevel.debug.allowedLevels, [.error, .warning, .info, .debug])
    }

    func testEmoji() {
        XCTAssertTrue(Logger.LogLevel.none.emoji.isEmpty)
        XCTAssertTrue(Logger.LogLevel.error.emoji.contains("‼️"))
        XCTAssertTrue(Logger.LogLevel.warning.emoji.contains("⚠️"))
        XCTAssertTrue(Logger.LogLevel.info.emoji.contains("✳️"))
        XCTAssertTrue(Logger.LogLevel.debug.emoji.contains("🔹"))
    }

    func testLogging() {
        var logger = Logger(
            subsystem: "com.paulofierro.PFToolboxTests",
            category: "PFToolboxTests"
        )
        logger.currentLogLevel = .error
        XCTAssertFalse(logger.debug("Test"))
        XCTAssertFalse(logger.info("Test"))
        XCTAssertFalse(logger.warn("Test"))
        XCTAssertTrue(logger.error("Test"))

        XCTAssertFalse(logger.error(nil))
    }
}
