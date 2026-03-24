//
//   LoggerTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct LoggerTests {
    @Test func existence() {
        let log = Logger(
            subsystem: "com.paulofierro.PFToolboxTests",
            category: "PFToolboxTests"
        )
        #expect(log.currentLogLevel == .debug)
    }

    @Test func `log types`() {
        #expect(Logger.LogLevel.none.logType == .default)
        #expect(Logger.LogLevel.error.logType == .error)
        #expect(Logger.LogLevel.warning.logType == .fault)
        #expect(Logger.LogLevel.info.logType == .info)
        #expect(Logger.LogLevel.debug.logType == .debug)
    }

    @Test func `allowed levels`() {
        #expect(Logger.LogLevel.none.allowedLevels == [])
        #expect(Logger.LogLevel.error.allowedLevels == [.error])
        #expect(Logger.LogLevel.warning.allowedLevels == [.error, .warning])
        #expect(Logger.LogLevel.info.allowedLevels == [.error, .warning, .info])
        #expect(Logger.LogLevel.debug.allowedLevels == [.error, .warning, .info, .debug])
    }

    @Test func emoji() {
        #expect(Logger.LogLevel.none.emoji.isEmpty)
        #expect(Logger.LogLevel.error.emoji.contains("‼️"))
        #expect(Logger.LogLevel.warning.emoji.contains("⚠️"))
        #expect(Logger.LogLevel.info.emoji.contains("✳️"))
        #expect(Logger.LogLevel.debug.emoji.contains("🔹"))
    }

    @Test func logging() {
        var logger = Logger(
            subsystem: "com.paulofierro.PFToolboxTests",
            category: "PFToolboxTests"
        )
        logger.currentLogLevel = .error
        #expect(!logger.debug("Test"))
        #expect(!logger.info("Test"))
        #expect(!logger.warn("Test"))
        #expect(logger.error("Test"))

        #expect(!logger.error(nil))
    }
}
