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
        if isRunningInXcode() {
            #expect(Bundle.main.bundleName == "xctest")
        } else {
            #expect(Bundle.main.bundleName == nil)
        }
    }

    @Test func bundleName() {
        if isRunningInXcode() {
            #expect(Bundle.main.bundleName == "xctest")
        } else {
            #expect(Bundle.main.bundleName == nil)
        }
    }

    @Test func versionNumber() throws {
        if isRunningInXcode() {
            let version = try #require(Bundle.main.versionNumber)
            #expect(version.isEmpty == false)
        } else {
            #expect(Bundle.main.versionNumber == nil)
        }
    }

    @Test func teamIdentifier() {
        #expect(Bundle.main.teamIdentifierPrefix == "")
    }

    @Test func identifier() {
        if isRunningInXcode() {
            #expect(Bundle.main.identifier == "com.apple.dt.xctest.tool")
        } else {
            #expect(Bundle.main.identifier == "com.paulofierro.pftoolbox.unknown")
        }
    }
}
