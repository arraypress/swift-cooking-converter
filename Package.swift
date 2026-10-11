// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CookingConverter",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "CookingConverter",
            targets: ["CookingConverter"]),
    ],
    targets: [
        .target(
            name: "CookingConverter"),
        .testTarget(
            name: "CookingConverterTests",
            dependencies: ["CookingConverter"]),
    ]
)

// Swift 7's import rule, today: a file must import every module whose members
// it uses, rather than leaning on another file's imports.
for target in package.targets where target.type != .system && target.type != .binary && target.type != .plugin {
    target.swiftSettings = (target.swiftSettings ?? []) + [.enableUpcomingFeature("MemberImportVisibility")]
}
