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
            url: "https://github.com/OuterCorner/OpenSSL/releases/download/1.2.0/OpenSSL.xcframework.zip",
            checksum: "b3949aaac5cb0ccb4e9d426a62f3ae858260e6c253972a663a9f46b7b261b0e1"
        )
    ]
)
