//
//   Logger.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

import Foundation
import os

/// The global logger. Remember to create your own!
public let log = Logger(subsystem: "com.paulofierro.PFToolbox", category: "PFToolbox")

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

        /// Returns the corresponding type for os_log usage
        var logType: OSLogType {
            switch self {
            case .error:
                return .error

            case .warning:
                return .fault

            case .info:
                return .info

            case .debug:
                return .debug

            default:
                return .default
            }
        }

        /// The type of logs allowed depending on the level
        var allowedLevels: [LogLevel] {
            switch self {
            case .none:
                return []

            case .error:
                return [.error]

            case .warning:
                return [.error, .warning]

            case .info:
                return [.error, .warning, .info]

            case .debug:
                return [.error, .warning, .info, .debug]
            }
        }
    }

    /// The default log level
    public var logLevel: LogLevel

    /// Creates an OSLog object using our specific subsystem
    private let logIdentifier: OSLog

    /// Creates an instance of the logger
    /// - Parameters:
    ///   - subsystem: The subsystem to use for the logger, e.g. "com.paulofierro.MyApp"
    ///   - category: The category to use for the logger, e.g. "MyApp"
    public init(subsystem: String, category: String, logLevel: LogLevel = .debug) {
        logIdentifier = OSLog(
            subsystem: subsystem,
            category: category
        )
        self.logLevel = logLevel
        info("Created logger...")
    }

    // MARK: - Public Methods

    /// Prints a debug message
    public func debug(_ message: String, file: String = #fileID, line: Int = #line, function: String = #function) {
        printMessage(message, emoji: "🔹🔹🔹", logLevel: .debug, file: file, line: line, function: function)
    }

    /// Prints an informative message
    public func info(_ message: String, file: String = #fileID, line: Int = #line, function: String = #function) {
        printMessage(message, emoji: "🔸🔸🔸", logLevel: .info, file: file, line: line, function: function)
    }

    /// Prints a warning message
    public func warn(_ message: String, file: String = #fileID, line: Int = #line, function: String = #function) {
        printMessage(message, emoji: "⚠️⚠️⚠️", logLevel: .warning, file: file, line: line, function: function)
    }

    /// Prints an error message
    public func error(_ message: String, file: String = #fileID, line: Int = #line, function: String = #function) {
        printMessage(message, emoji: "‼️‼️‼️", logLevel: .error, file: file, line: line, function: function)
    }
}

// MARK: - Private Methods

extension Logger {
    /// Prints a message to the log if available
    // swiftlint:disable:next function_parameter_count
    private func printMessage(_ message: String, emoji: String, logLevel: LogLevel, file: String, line: Int, function: String) {
        guard logLevel.allowedLevels.contains(logLevel) else {
            return
        }

        // Figure out where the log message came from
        var emitter = ""
        if let fileURL = URL(string: file) {
            let fileType = ".\(fileURL.pathExtension)"
            let filename = fileURL.lastPathComponent.replacingOccurrences(of: fileType, with: "")
            let functionName = function.replacingOccurrences(of: "()", with: "")
            emitter = "[\(filename) \(functionName)]: "
        }

        os_log(
            "%{public}@ %{public}@ %{public}@",
            log: logIdentifier,
            type: logLevel.logType,
            emitter, emoji, message
        )
    }
}
