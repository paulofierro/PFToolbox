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
    /// Defines the level of logs
    public enum LogLevel: String {
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

    /// The default log level
    var currentLogLevel: LogLevel

    #if canImport(os)
    /// Creates an OSLog object using our specific subsystem
    private let logIdentifier: OSLog
    #else
    private let subsystem: String
    private let category: String
    #endif

    /// Creates an instance of the logger
    /// - Parameters:
    ///   - subsystem: The subsystem to use for the logger, e.g. "com.paulofierro.MyApp"
    ///   - category: The category to use for the logger, e.g. "MyApp"
    public init(subsystem: String, category: String, logLevel: LogLevel = .debug) {
        #if canImport(os)
        logIdentifier = OSLog(
            subsystem: subsystem,
            category: category
        )
        #else
        self.subsystem = subsystem
        self.category = category
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
        return true
    }
}
