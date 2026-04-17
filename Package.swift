// swift-tools-version: 6.2.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let name = "PFToolbox"

#if os(Linux)
let packageDependencies: [Package.Dependency] = []
let testDependencies: [Target.Dependency] = [
    Target.Dependency(stringLiteral: name)
]
#else
let packageDependencies: [Package.Dependency] = [
    .package(
        url: "https://github.com/sindresorhus/ExceptionCatcher",
        from: "2.2.0"
    ),
    .package(
        url: "https://github.com/mattgallagher/CwlPreconditionTesting",
        from: "2.2.2"
    )
]
let testDependencies: [Target.Dependency] = [
    Target.Dependency(stringLiteral: name),
    "ExceptionCatcher",
    "CwlPreconditionTesting"
]
#endif

let package = Package(
    name: name,
    platforms: [
        .macOS(.v12),
        .iOS(.v17),
        .tvOS(.v18),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: name,
            targets: [
                name
            ]
        )
    ],
    dependencies: packageDependencies,
    targets: [
        .target(
            name: name,
            dependencies: [],
            resources: []
        ),
        .testTarget(
            name: "\(name)Tests",
            dependencies: testDependencies,
            resources: [
                .process("Resources")
            ]
        )
    ],
    swiftLanguageModes: [.v5]
)
