// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PFToolbox",
    platforms: [
        .macOS(.v12),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "PFToolbox",
            targets: ["PFToolbox"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "PFToolbox",
            dependencies: []
        ),
        .testTarget(
            name: "PFToolboxTests",
            dependencies: ["PFToolbox"]
        ),
    ]
)
