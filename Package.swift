// swift-tools-version: 5.9
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
    dependencies: [
        .package(
            url: "https://github.com/sindresorhus/ExceptionCatcher",
            from: "2.2.0"
        ),
        .package(
            url: "https://github.com/mattgallagher/CwlPreconditionTesting",
            from: "2.2.2"
        )
    ],
    targets: [
        .target(
            name: name,
            dependencies: [],
            resources: []
        ),
        .testTarget(
            name: "\(name)Tests",
            dependencies: [
                Target.Dependency(stringLiteral: name),
                "ExceptionCatcher",
                "CwlPreconditionTesting"
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
