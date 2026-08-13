//
//   BundleTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
@testable import PFToolbox
import Testing

/// These build a real bundle on disk rather than asserting against `Bundle.main`, whose
/// contents depend entirely on the host: Xcode runs the suite inside the `xctest` tool, while
/// SwiftPM runs it through `swiftpm-testing-helper`, which has no Info.plist at all.
struct BundleTests {
    // MARK: - Info.plist backed values

    @Test func `reads values from Info.plist`() throws {
        let bundle = try TemporaryBundle(
            info: [
                "CFBundleExecutable": "MyApp",
                "CFBundleName": "My App",
                "CFBundleShortVersionString": "2.5.1",
                "CFBundleIdentifier": "com.paulofierro.MyApp",
                "TeamIdentifierPrefix": "ABCDE12345."
            ]
        )
        defer { bundle.remove() }

        #expect(bundle.value.executableName == "MyApp")
        #expect(bundle.value.bundleName == "My App")
        #expect(bundle.value.versionNumber == "2.5.1")
        #expect(bundle.value.identifier == "com.paulofierro.MyApp")
        #expect(bundle.value.teamIdentifierPrefix == "ABCDE12345.")
    }

    @Test func `missing values are nil`() throws {
        let bundle = try TemporaryBundle(info: ["CFBundlePackageType": "BNDL"])
        defer { bundle.remove() }

        #expect(bundle.value.executableName == nil)
        #expect(bundle.value.bundleName == nil)
        #expect(bundle.value.versionNumber == nil)
    }

    // MARK: - Fallbacks

    @Test func `team identifier prefix falls back to empty`() throws {
        let bundle = try TemporaryBundle(info: ["CFBundleName": "No Team"])
        defer { bundle.remove() }

        #expect(bundle.value.teamIdentifierPrefix.isEmpty)
    }

    @Test func `identifier falls back when the bundle has no identifier`() throws {
        let bundle = try TemporaryBundle(info: ["CFBundleName": "Anonymous"])
        defer { bundle.remove() }

        #expect(bundle.value.identifier == "com.paulofierro.pftoolbox.unknown")
    }

    // MARK: - App path

    @Test func `app path is the directory containing the bundle`() {
        #expect(Bundle.appPath == Bundle.main.bundleURL.deletingLastPathComponent())
        #expect(Bundle.appPath.absoluteString.isNotEmpty)
    }
}

/// A minimal bundle written to a unique temporary directory, so each test controls exactly
/// what its `Info.plist` contains.
struct TemporaryBundle {
    let value: Bundle
    private let root: URL

    init(named name: String = "Fixture", info: [String: Any], resources: [String: Data] = [:]) throws {
        root = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)

        let bundleURL = root.appendingPathComponent("\(name).bundle", isDirectory: true)
        // Bundles are laid out differently per platform, and Foundation only finds the
        // Info.plist and resources if they sit where that platform expects them.
        #if os(macOS)
        let contentsURL = bundleURL.appendingPathComponent("Contents", isDirectory: true)
        let resourcesURL = contentsURL.appendingPathComponent("Resources", isDirectory: true)
        #else
        let contentsURL = bundleURL
        let resourcesURL = bundleURL
        #endif

        try FileManager.default.createDirectory(at: resourcesURL, withIntermediateDirectories: true)
        let plist = try PropertyListSerialization.data(
            fromPropertyList: info,
            format: .xml,
            options: 0
        )
        try plist.write(to: contentsURL.appendingPathComponent("Info.plist"))

        for (filename, contents) in resources {
            try contents.write(to: resourcesURL.appendingPathComponent(filename))
        }

        guard let bundle = Bundle(url: bundleURL) else {
            throw GenericError.custom("Could not open the bundle at \(bundleURL.path)")
        }
        value = bundle
    }

    func remove() {
        try? FileManager.default.removeItem(at: root)
    }
}
