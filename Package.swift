// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenSSL",
    platforms: [
        .macOS(.v10_10), .iOS(.v9)
        ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "OpenSSL",
            targets: ["OpenSSL"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "OpenSSL",
            url: "https://github.com/OuterCorner/OpenSSL/releases/download/1.1.1+220118.0/OpenSSL.xcframework.zip",
            checksum: "51f0c234966b3ade6cbe14d957e6e3e2f28445dd378ef0a46de8fc1c5427c0c9"
        )
    ]
)
