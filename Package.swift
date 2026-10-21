// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenSSL",
    platforms: [
        .macOS("14.6"), .iOS("17.6")
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
            url: "https://github.com/OuterCorner/OpenSSL/releases/download/4.0.3/OpenSSL.xcframework.zip",
            checksum: "ebd66bfb77feeb598fb63d00f08a131f75bae66d5f853bf4c3e894e9199124cd"
        )
    ]
)
