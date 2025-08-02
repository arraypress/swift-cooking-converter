// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CookingConverter",  // Package name
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "CookingConverter",  // What you import
            targets: ["CookingConverter"]),
    ],
    targets: [
        .target(
            name: "CookingConverter"),  // Target/module name
        .testTarget(
            name: "CookingConverterTests",
            dependencies: ["CookingConverter"]),
    ]
)
