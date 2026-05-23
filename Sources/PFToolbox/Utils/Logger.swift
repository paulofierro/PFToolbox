//
//   Logger.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
#if canImport(os)
import os
#endif

/// A simple logger.
/// To see these log messages outside of Xcode you can use the Console or Terminal:
///     - Console: Search for `category:{{MY_CATEGORY}}`, and enable Info and Debug messages from the Action menu.
///     - Terminal: Run `log stream --level=debug --predicate 'subsystem contains "{{MY_SUBSYSTEM}}"'`
public struct Logger {
    /// The default log level
    var currentLogLevel: LogLevel

    /// The subsystem this logger was created with, e.g. "com.paulofierro.MyApp"
    public let subsystem: String

    /// The category this logger was created with, e.g. "MyApp"
    public let category: String

    #if canImport(os)
    /// Creates an OSLog object using our specific subsystem
    private let logIdentifier: OSLog
    #endif

    /// Creates an instance of the logger
    /// - Parameters:
    ///   - subsystem: The subsystem to use for the logger, e.g. "com.paulofierro.MyApp"
    ///   - category: The category to use for the logger, e.g. "MyApp"
    public init(subsystem: String, category: String, logLevel: LogLevel = .debug) {
        self.subsystem = subsystem
        self.category = category
        #if canImport(os)
        logIdentifier = OSLog(
            subsystem: subsystem,
            category: category
        )
        #endif
        currentLogLevel = logLevel
    }

    // MARK: - Public Methods

    /// Prints a debug message
    @discardableResult
    public func debug(_ message: String?, file: String = #fileID, line: Int = #line, function: String = #function) -> Bool {
        printMessage(message, logLevel: .debug, file: file, line: line, function: function)
    }

    /// Prints an informative message
    @discardableResult
    public func info(_ message: String?, file: String = #fileID, line: Int = #line, function: String = #function) -> Bool {
        printMessage(message, logLevel: .info, file: file, line: line, function: function)
    }

    /// Prints a warning message
    @discardableResult
    public func warn(_ message: String?, file: String = #fileID, line: Int = #line, function: String = #function) -> Bool {
        printMessage(message, logLevel: .warning, file: file, line: line, function: function)
    }

    /// Prints an error message
    @discardableResult
    public func error(_ message: String?, file: String = #fileID, line: Int = #line, function: String = #function) -> Bool {
        printMessage(message, logLevel: .error, file: file, line: line, function: function)
    }
}

extension Logger {
    /// Defines the level of logs
    public enum LogLevel: String, Sendable {
        case none
        case error
        case warning
        case info
        case debug
        
#if canImport(os)
        /// Returns the corresponding type for os_log usage
        var logType: OSLogType {
            switch self {
            case .error:
                    .error
                
            case .warning:
                    .fault
                
            case .info:
                    .info
                
            case .debug:
                    .debug
                
            default:
                    .default
            }
        }
#endif
        
        /// The type of logs allowed depending on the level
        var allowedLevels: [LogLevel] {
            switch self {
            case .none:
                []
                
            case .error:
                [.error]
                
            case .warning:
                [.error, .warning]
                
            case .info:
                [.error, .warning, .info]
                
            case .debug:
                [.error, .warning, .info, .debug]
            }
        }
        
        /// Returns the corresponding emoji
        var emoji: String {
            switch self {
            case .error:
                "‼️‼️‼️"
                
            case .warning:
                "⚠️⚠️⚠️"
                
            case .info:
                "✳️✳️✳️"
                
            case .debug:
                "🔹🔹🔹"
                
            default:
                ""
            }
        }
    }
}

// MARK: - Forwarding

extension Logger {
    /// A closure invoked for every log message that passes the level filter.
    /// Use to bridge log output to external systems (Sentry, Crashlytics, file sinks, etc.).
    /// Forwarders may be invoked from any thread, so the closure must be `@Sendable`.
    public typealias Forwarder = @Sendable (_ message: String, _ level: LogLevel, _ subsystem: String, _ category: String, _ file: String, _ line: Int, _ function: String) -> Void

    /// An opaque handle returned by `addForwarder`. Pass it to `removeForwarder(token:)` to unregister.
    public struct ForwarderToken: Hashable, Sendable {
        fileprivate let id: UUID
    }

    private static let forwarderLock = NSLock()
    nonisolated(unsafe) private static var forwarders: [(token: ForwarderToken, forwarder: Forwarder)] = []

    /// Registers a closure to receive every log message that survives the level filter.
    ///
    /// Forwarders run in the order they were added, synchronously on whatever thread the log call
    /// originated from. Keep them fast — anything that may block (network I/O, disk writes, etc.)
    /// should dispatch its work asynchronously inside the closure, otherwise it will stall the
    /// caller (including the main thread).
    ///
    /// Forwarders may safely call back into `Logger` — the registration list is snapshotted before
    /// dispatch, so re-entrant logging will not deadlock. Forwarders added or removed from inside
    /// a closure only take effect on the *next* log call, not the current one.
    ///
    /// - Returns: A token that can be passed to `removeForwarder(token:)` to unregister this forwarder.
    @discardableResult
    public static func addForwarder(_ forwarder: @escaping Forwarder) -> ForwarderToken {
        let token = ForwarderToken(id: UUID())
        forwarderLock.lock()
        defer { forwarderLock.unlock() }
        forwarders.append((token, forwarder))
        return token
    }

    /// Removes a previously registered forwarder by its token. No-op if the token is unknown.
    public static func removeForwarder(token: ForwarderToken) {
        forwarderLock.lock()
        defer { forwarderLock.unlock() }
        forwarders.removeAll { $0.token == token }
    }

    /// Removes all registered forwarders. Primarily useful in tests.
    public static func removeAllForwarders() {
        forwarderLock.lock()
        defer { forwarderLock.unlock() }
        forwarders.removeAll()
    }

    private static func dispatchToForwarders(_ message: String, level: LogLevel, subsystem: String, category: String, file: String, line: Int, function: String) {
        forwarderLock.lock()
        guard forwarders.isNotEmpty else {
            forwarderLock.unlock()
            return
        }
        
        let snapshot = forwarders
        forwarderLock.unlock()
        for entry in snapshot {
            entry.forwarder(message, level, subsystem, category, file, line, function)
        }
    }
}

// MARK: - Private Methods

extension Logger {
    /// Prints a message to the log if available
    @discardableResult
    private func printMessage(_ message: String?, logLevel: LogLevel, file: String, line: Int, function: String) -> Bool {
        guard let message else { return false }
        guard currentLogLevel.allowedLevels.contains(logLevel) else {
            return false
        }

        // Figure out where the log message came from
        var emitter = ""
        if let fileURL = URL(string: file) {
            let fileType = ".\(fileURL.pathExtension)"
            let filename = fileURL.lastPathComponent.replacingOccurrences(of: fileType, with: "")
            let functionName = function.replacingOccurrences(of: "()", with: "")
            emitter = "[\(filename) \(functionName)]: "
        }

        #if canImport(os)
        os_log(
            "%{public}@ %{public}@ %{public}@",
            log: logIdentifier,
            type: logLevel.logType,
            emitter, logLevel.emoji, message
        )
        #else
        print("[\(subsystem)/\(category)] \(emitter)\(logLevel.emoji) \(message)")
        #endif

        Logger.dispatchToForwarders(message, level: logLevel, subsystem: subsystem, category: category, file: file, line: line, function: function)
        return true
    }
}
