// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenSSL",
    platforms: [
        .macOS(.v10_10), .iOS(.v8)
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
            url: "https://github.com/OuterCorner/OpenSSL/releases/download/1.1.1+210909.0/OpenSSL.xcframework.zip",
            checksum: "6769fbf387cb71d57f3f9bb82f749de5093ccfd8724dd87137560313b9418918"
        )
    ]
)
