//
//   Bundle.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

public extension Bundle {
    /// Returns the path to the app
    static var appPath: URL {
        Bundle.main.bundleURL.deletingLastPathComponent()
    }

    /// Returns the executable name
    var executableName: String? {
        infoDictionary?["CFBundleExecutable"] as? String
    }

    /// Returns the bundle name
    var bundleName: String? {
        infoDictionary?["CFBundleName"] as? String
    }

    /// The version number as set in Info.plist
    var versionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }

    /// The team identifier prefix
    var teamIdentifierPrefix: String {
        infoDictionary?["TeamIdentifierPrefix"] as? String ?? ""
    }

    /// Returns the bundle identifier as a non-optional string
    var identifier: String {
        Bundle.main.bundleIdentifier ?? "com.paulofierro.pftoolbox.unknown"
    }
}
