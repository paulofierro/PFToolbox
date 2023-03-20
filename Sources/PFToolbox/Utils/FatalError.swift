//
//   FatalError.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

import Foundation

// Modified from https://stackoverflow.com/questions/32873212/unit-test-fatalerror-in-swift

// Overrides Swift global `fatalError`
public func fatalError(_ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
}

public func unreachable() -> Never {
    repeat {
        RunLoop.current.run()
    } while true
}

/// Utility functions that can replace and restore the `fatalError` global function.
public enum FatalErrorUtil {
    typealias FatalErrorClosureType = (String, StaticString, UInt) -> Never

    /// Called by the custom implementation of `fatalError`.
    static var fatalErrorClosure: FatalErrorClosureType = defaultFatalErrorClosure

    /// Backup of the original Swift `fatalError`
    private static let defaultFatalErrorClosure = {
        Swift.fatalError($0, file: $1, line: $2)
    }

    /// Replace the `fatalError` global function with something else.
    static func replaceFatalError(closure: @escaping FatalErrorClosureType) {
        fatalErrorClosure = closure
    }

    /// Restore the `fatalError` global function back to the original Swift implementation
    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}
