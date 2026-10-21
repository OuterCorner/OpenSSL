# OpenSSL.framework

![Platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20iOS-lightgrey.svg)
![Carthage](https://img.shields.io/badge/Carthage-compatible-green.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

This project neatly packs OpenSSL into a dynamic framework for iOS and macOS.

Current OpenSSL version used: 4.0.3

## Installation

You have a few different options:

### Manual installation

 *  Include the OpenSSL.xcodeproj as a dependency in your project. This is what the projects under ```Examples/``` are doing. Doing this means OpenSSL will be compiled alongside your project, including after every clean (building OpenSSL can take a while).  
 *  Use a pre-built OpenSSL.xcframework. You can find them under [Releases](https://github.com/OuterCorner/OpenSSL/releases).

### SwiftPM

In your `Package.swift`, add `OpenSSL` as a dependency:
```swift
dependencies: [
  .package(url: "https://github.com/OuterCorner/OpenSSL", from: "4.0.3")
],
```

Associate the dependency with your target:
```swift
targets: [
  .target(name: "App", dependencies: ["OpenSSL"])
]
```

## Building

Run `bash Scripts/create-xcframework.sh` with Xcode selected as the active developer directory.
The result is `build/OpenSSL.xcframework`, including dSYMs, with these slices:

* iOS: arm64 (iOS 17.6 or later)
* iOS Simulator: arm64 and x86_64 (iOS 17.6 or later)
* macOS: arm64 and x86_64 (macOS 14.6 or later)

The first build downloads the OpenSSL source archive from its GitHub release.
The scripts build static OpenSSL libraries into the dynamic framework, using built-in
providers with dynamic module loading disabled. Bitcode is disabled for current Xcode.
Builds reuse the libraries only while the version, options, architectures, SDK,
configuration, deployment targets, and build script match. Clean the project to force a rebuild.

The SwiftPM manifest references the ZIP archive attached to the matching GitHub release.
When publishing a release, update its URL and checksum in `Package.swift`.

## Usage

After importing the umbrella header:

```ObjC
#import <OpenSSL/OpenSSL.h>
```
You can simply start using OpenSSL APIs as usual.

```ObjC
Byte buffer[128];
    
int rc = RAND_bytes(buffer, sizeof(buffer));
```

See example projects under ```Examples/```.

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE).

Note the underlying OpenSSL library [LICENSE](https://github.com/openssl/openssl/blob/master/LICENSE) still applies when using this project.

## Acknowledgments

The build scripts for this project were based on:

 * [sqlcipher/openssl-xcode](https://github.com/sqlcipher/openssl-xcode)
 * [keeshux/openssl-apple](https://github.com/keeshux/openssl-apple)
 * [sinofool/build-openssl-ios](https://github.com/sinofool/build-openssl-ios)

