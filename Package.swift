// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PremiumKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "PremiumKit",
            targets: ["PremiumKit"]
        ),
    ],
    targets: [
        .target(
            name: "PremiumKit"
        ),
        .testTarget(
            name: "PremiumKitTests",
            dependencies: ["PremiumKit"]
        ),
    ]
)
