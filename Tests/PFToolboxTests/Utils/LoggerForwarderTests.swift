//
//  LoggerTests 2.swift
//  PFToolbox
//
//  Created by Paulo Fierro on 23/05/2026.
//

import Foundation
@testable import PFToolbox
import Testing

@Suite(.serialized)
struct LoggerForwarderTests {
    init() {
        // Forwarders are global static state; start each test from a clean slate.
        Logger.removeAllForwarders()
    }

    private func makeLogger(level: Logger.LogLevel = .debug) -> Logger {
        Logger(
            subsystem: "com.paulofierro.PFToolboxTests",
            category: "PFToolboxTests",
            logLevel: level
        )
    }

    @Test func `forwarder receives message that passes level filter`() {
        let sink = ForwarderSink()
        Logger.addForwarder(sink.makeForwarder())
        defer { Logger.removeAllForwarders() }

        let marker = UUID().uuidString
        makeLogger().info(marker)

        let matched = sink.entries.filter { $0.message == marker }
        #expect(matched.count == 1)
        #expect(matched.first?.level == .info)
    }

    @Test func `forwarder receives subsystem and category from emitting logger`() throws {
        let sink = ForwarderSink()
        Logger.addForwarder(sink.makeForwarder())
        defer { Logger.removeAllForwarders() }

        let marker = UUID().uuidString
        let logger = Logger(subsystem: "com.example.subsys", category: "MyCat")
        logger.warn(marker)

        let entry = try #require(sink.entries.first { $0.message == marker })
        #expect(entry.subsystem == "com.example.subsys")
        #expect(entry.category == "MyCat")
    }

    @Test func `forwarder receives source location`() throws {
        let sink = ForwarderSink()
        Logger.addForwarder(sink.makeForwarder())
        defer { Logger.removeAllForwarders() }

        let marker = UUID().uuidString
        let logger = makeLogger()
        let expectedLine = #line + 1
        logger.error(marker)

        let entry = try #require(sink.entries.first { $0.message == marker })
        #expect(entry.line == expectedLine)
        #expect(entry.file.contains("LoggerForwarderTests.swift"))
        #expect(entry.function.contains("forwarder receives source location"))
    }

    @Test func `forwarder is not invoked for filtered-out levels`() {
        let sink = ForwarderSink()
        Logger.addForwarder(sink.makeForwarder())
        defer { Logger.removeAllForwarders() }

        let suppressed = UUID().uuidString
        let kept = UUID().uuidString
        let logger = makeLogger(level: .error)
        logger.debug(suppressed)
        logger.info(suppressed)
        logger.warn(suppressed)
        logger.error(kept)

        #expect(sink.entries.contains { $0.message == kept })
        #expect(!sink.entries.contains { $0.message == suppressed })
    }

    @Test func `forwarder is not invoked for nil message`() {
        let sink = ForwarderSink()
        Logger.addForwarder(sink.makeForwarder())
        defer { Logger.removeAllForwarders() }

        let countBefore = sink.entries.count
        makeLogger().info(nil)

        #expect(sink.entries.count == countBefore)
    }

    @Test func `multiple forwarders all fire in registration order`() {
        let order = ForwarderSink()
        let marker = UUID().uuidString

        // Use the message slot to record arrival order via a per-forwarder label.
        // Filtering on the original marker via subsystem ensures we ignore noise.
        Logger.addForwarder { msg, _, subsystem, _, _, _, _ in
            guard subsystem == marker else { return }
            order.append(.init(message: "first", level: .info, subsystem: subsystem, category: "", file: "", line: 0, function: ""))
            _ = msg
        }
        Logger.addForwarder { _, _, subsystem, _, _, _, _ in
            guard subsystem == marker else { return }
            order.append(.init(message: "second", level: .info, subsystem: subsystem, category: "", file: "", line: 0, function: ""))
        }
        Logger.addForwarder { _, _, subsystem, _, _, _, _ in
            guard subsystem == marker else { return }
            order.append(.init(message: "third", level: .info, subsystem: subsystem, category: "", file: "", line: 0, function: ""))
        }
        defer { Logger.removeAllForwarders() }

        Logger(subsystem: marker, category: "x").info("dispatch")

        #expect(order.entries.map(\.message) == ["first", "second", "third"])
    }

    @Test func `removeForwarder removes only the specified forwarder`() {
        let keptSink = ForwarderSink()
        let removedSink = ForwarderSink()

        Logger.addForwarder(keptSink.makeForwarder())
        let removedToken = Logger.addForwarder(removedSink.makeForwarder())
        defer { Logger.removeAllForwarders() }

        Logger.removeForwarder(token: removedToken)
        let marker = UUID().uuidString
        makeLogger().info(marker)

        #expect(keptSink.entries.contains { $0.message == marker })
        #expect(!removedSink.entries.contains { $0.message == marker })
    }

    @Test func `removeForwarder with unknown token is a no-op`() {
        let sink = ForwarderSink()
        let realToken = Logger.addForwarder(sink.makeForwarder())
        defer { Logger.removeAllForwarders() }

        // Register and immediately remove a second forwarder, getting an orphaned token.
        let orphanedToken = Logger.addForwarder { _, _, _, _, _, _, _ in }
        Logger.removeForwarder(token: orphanedToken)

        // Removing again should not affect the surviving forwarder.
        Logger.removeForwarder(token: orphanedToken)
        _ = realToken

        let marker = UUID().uuidString
        makeLogger().info(marker)

        #expect(sink.entries.contains { $0.message == marker })
    }

    @Test func `removeAllForwarders clears the registry`() {
        let sinkA = ForwarderSink()
        let sinkB = ForwarderSink()
        Logger.addForwarder(sinkA.makeForwarder())
        Logger.addForwarder(sinkB.makeForwarder())

        Logger.removeAllForwarders()
        let marker = UUID().uuidString
        makeLogger().info(marker)

        #expect(!sinkA.entries.contains { $0.message == marker })
        #expect(!sinkB.entries.contains { $0.message == marker })
    }

    @Test func `addForwarder returns unique tokens`() {
        let tokenA = Logger.addForwarder { _, _, _, _, _, _, _ in }
        let tokenB = Logger.addForwarder { _, _, _, _, _, _, _ in }
        defer { Logger.removeAllForwarders() }
        #expect(tokenA != tokenB)
    }
}

/// A thread-safe sink used by tests to capture forwarder invocations.
/// Marked `@unchecked Sendable` because access is guarded by an `NSLock`.
private final class ForwarderSink: @unchecked Sendable {
    struct Entry: Equatable {
        let message: String
        let level: Logger.LogLevel
        let subsystem: String
        let category: String
        let file: String
        let line: Int
        let function: String
    }
    
    private let lock = NSLock()
    private var _entries: [Entry] = []
    
    func append(_ entry: Entry) {
        lock.lock(); defer { lock.unlock() }
        _entries.append(entry)
    }
    
    var entries: [Entry] {
        lock.lock(); defer { lock.unlock() }
        return _entries
    }
    
    /// Returns a `Logger.Forwarder` that writes into this sink.
    func makeForwarder() -> Logger.Forwarder {
        { [self] message, level, subsystem, category, file, line, function in
            self.append(
                Entry(
                    message: message,
                    level: level,
                    subsystem: subsystem,
                    category: category,
                    file: file,
                    line: line,
                    function: function
                )
            )
        }
    }
}
