#!/bin/bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJ_DIR="$(cd "$SCRIPTS_DIR/.." && pwd)"
BUILD_DIR="$PROJ_DIR/build"

for PLATFORM in 'iOS' 'iOS Simulator' 'macOS'; do
    xcrun xcodebuild build -project "$PROJ_DIR/OpenSSL.xcodeproj" \
        -scheme OpenSSL -configuration Release -destination "generic/platform=$PLATFORM" \
        SYMROOT="$BUILD_DIR" ONLY_ACTIVE_ARCH=NO CODE_SIGNING_ALLOWED=NO
done

# Build into a temporary output so failed packaging preserves the previous result.
OUTPUT="$BUILD_DIR/OpenSSL-new.xcframework"
rm -rf "$OUTPUT"
xcrun xcodebuild -create-xcframework \
    -framework "$BUILD_DIR/Release/OpenSSL.framework" \
    -debug-symbols "$BUILD_DIR/Release/OpenSSL.framework.dSYM" \
    -framework "$BUILD_DIR/Release-iphoneos/OpenSSL.framework" \
    -debug-symbols "$BUILD_DIR/Release-iphoneos/OpenSSL.framework.dSYM" \
    -framework "$BUILD_DIR/Release-iphonesimulator/OpenSSL.framework" \
    -debug-symbols "$BUILD_DIR/Release-iphonesimulator/OpenSSL.framework.dSYM" \
    -output "$OUTPUT"
rm -rf "$BUILD_DIR/OpenSSL.xcframework"
mv "$OUTPUT" "$BUILD_DIR/OpenSSL.xcframework"
