// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let name = "PFToolbox"
let package = Package(
    name: name,
    platforms: [
        .macOS(.v12),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: name,
            targets: [
                name
            ]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: name,
            dependencies: []
        ),
        .testTarget(
            name: "\(name)Tests",
            dependencies: [
                Target.Dependency(stringLiteral: name)
            ]
        )
    ]
)
