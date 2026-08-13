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

/// Returns true if the process was launched to run a test suite.
///
/// Covers both hosts this package is tested under. XCTest sets environment variables that
/// nothing else does, but SwiftPM runs swift-testing suites through its own helper binary
/// without loading XCTest at all, so there is nothing in the environment to look for and the
/// executable name is the only signal left.
public func isRunningTests() -> Bool {
    let environment = ProcessInfo.processInfo.environment
    let testEnvironmentKeys = [
        "XCTestConfigurationFilePath",
        "XCTestBundlePath",
        "XCTestSessionIdentifier"
    ]

    if testEnvironmentKeys.contains(where: { environment[$0] != nil }) {
        return true
    }

    guard let executable = ProcessInfo.processInfo.arguments.first else {
        return false
    }
    // Darwin runs the suite through `swiftpm-testing-helper` or the `xctest` tool, while Linux
    // builds the bundle as a standalone `<Package>PackageTests.xctest` executable.
    let name = URL(fileURLWithPath: executable).lastPathComponent
    return name == "swiftpm-testing-helper"
        || name == "xctest"
        || name.hasSuffix(".xctest")
        || name.hasSuffix("PackageTests")
}

/// The global logger. Remember to create your own!
public let log = Logger(
    subsystem: "com.paulofierro.PFToolbox",
    category: "PFToolbox"
)
