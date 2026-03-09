//
//   Globals.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

/// Returns true if currently showing a SwiftUI Preview
public func isShowingPreview() -> Bool {
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}

/// The global logger. Remember to create your own!
public let log = Logger(
    subsystem: "com.paulofierro.PFToolbox",
    category: "PFToolbox"
)
