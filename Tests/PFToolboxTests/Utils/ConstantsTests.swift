//
//   ConstantsTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct ConstantsTests {
    @Test func `version number`() {
        #expect(Constants.versionNumber.isNotEmpty)
    }

    @Test func `version text`() {
        #expect(Constants.versionText == "Version \(Constants.versionNumber)")
    }

    @Test func `company url`() {
        #expect(Constants.companyUrl.absoluteString == "https://jadehopper.com")
    }

    #if canImport(UIKit)
    @Test func `settings url`() {
        #expect(Constants.settingsUrl.absoluteString.isNotEmpty)
    }
    #endif
}
