//
//   BundleTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import XCTest

final class BundleTests: XCTestCase {
    func testAppPath() {
        XCTAssertNotNil(Bundle.appPath.absoluteString)
    }

    func testExecutableName() {
        XCTAssertEqual(Bundle.main.executableName, "xctest")
    }

    func testBundleName() {
        XCTAssertEqual(Bundle.main.bundleName, "xctest")
    }

    func testVersionNumber() throws {
        let version = try XCTUnwrap(Bundle.main.versionNumber)
        if #available(macOS 15, *) {
            XCTAssertTrue(version.contains("16."))
        } else if #available(macOS 14, *) {
            XCTAssertTrue(version.contains("15."))
        } else {
            XCTAssertTrue(version.contains("14."))
        }
    }

    func testTeamIdentifier() {
        XCTAssertEqual(Bundle.main.teamIdentifierPrefix, "")
    }

    func testIdentifier() {
        XCTAssertEqual(Bundle.main.identifier, "com.apple.dt.xctest.tool")
    }
}
