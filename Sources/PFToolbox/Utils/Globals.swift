//
//   Globals.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

/// Returns true if currently showing a SwiftUI Preview
public func isShowingPreview() -> Bool {
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}

/// Returns true if currently running on Github Actions
/// Source: https://docs.github.com/en/actions/learn-github-actions/variables
public func isRunningOnCI() -> Bool {
    ProcessInfo.processInfo.environment["CI"] == "true"
}

public func isRunningInXcode() -> Bool {
    ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}

/// The global logger. Remember to create your own!
public let log = Logger(
    subsystem: "com.paulofierro.PFToolbox",
    category: "PFToolbox"
)
