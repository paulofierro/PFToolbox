//
//   BundleTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

struct BundleTests {
    @Test func appPath() {
        #expect(Bundle.appPath.absoluteString.isEmpty == false)
    }

    @Test func executableName() {
        #expect(Bundle.main.executableName == "xctest")
    }

    @Test func bundleName() {
        #expect(Bundle.main.bundleName == "xctest")
    }

    @Test func versionNumber() throws {
        let version = try #require(Bundle.main.versionNumber)
        if #available(macOS 15, *) {
            #expect(version.contains("16."))
        } else if #available(macOS 14, *) {
            #expect(version.contains("15."))
        } else {
            #expect(version.contains("14."))
        }
    }

    @Test func teamIdentifier() {
        #expect(Bundle.main.teamIdentifierPrefix == "")
    }

    @Test func identifier() {
        #expect(Bundle.main.identifier == "com.apple.dt.xctest.tool")
    }
}
