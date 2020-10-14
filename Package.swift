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
			type: .dynamic,
            targets: ["OpenSSL"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "OpenSSL",
            url: "https://github.com/OuterCorner/OpenSSL/releases/download/1.1.1_201014.0/OpenSSL.xcframework.zip",
            checksum: "7c81672c45face2875cb88e31d3dbf7e9f45edd7a41ce35ed0f933c0e9484f5e"
        )
    ]
)
