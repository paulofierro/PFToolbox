//
//   BundleTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

struct BundleTests {
    @Test func `app path`() {
        #expect(Bundle.appPath.absoluteString.isEmpty == false)
    }

    @Test func `executable name`() {
        if isRunningInXcode() {
            #expect(Bundle.main.bundleName == "xctest")
        } else {
            #expect(Bundle.main.bundleName == nil)
        }
    }

    @Test func `bundle name`() {
        if isRunningInXcode() {
            #expect(Bundle.main.bundleName == "xctest")
        } else {
            #expect(Bundle.main.bundleName == nil)
        }
    }

    @Test func `version number`() throws {
        if isRunningInXcode() {
            let version = try #require(Bundle.main.versionNumber)
            #expect(version.isEmpty == false)
        } else {
            #expect(Bundle.main.versionNumber == nil)
        }
    }

    @Test func `team identifier`() {
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
