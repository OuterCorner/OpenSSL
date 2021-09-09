#!/bin/bash

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
PROJ_DIR="$SCRIPTS_DIR/.."

XCBUILD="xcrun xcodebuild"

$XCBUILD build -project "$PROJ_DIR/OpenSSL.xcodeproj" -scheme 'OpenSSL' -configuration Release -destination 'generic/platform=iOS' SYMROOT='build' -ENABLE_BITCODE=YES
$XCBUILD build -project "$PROJ_DIR/OpenSSL.xcodeproj" -scheme 'OpenSSL' -configuration Release -destination 'generic/platform=iOS Simulator' SYMROOT='build' -ENABLE_BITCODE=YES
$XCBUILD build -project "$PROJ_DIR/OpenSSL.xcodeproj" -scheme 'OpenSSL' -configuration Release -destination 'generic/platform=macOS' SYMROOT='build'


$XCBUILD -create-xcframework \
	-framework "$PROJ_DIR/build/Release/OpenSSL.framework"\
	-debug-symbols "$PROJ_DIR/build/Release/OpenSSL.framework.dSYM"\
	-framework "$PROJ_DIR/build/Release-iphoneos/OpenSSL.framework"\
	-debug-symbols "$PROJ_DIR/build/Release-iphoneos/OpenSSL.framework.dSYM"\
	-framework "$PROJ_DIR/build/Release-iphonesimulator/OpenSSL.framework"\
	-debug-symbols "$PROJ_DIR/build/Release-iphonesimulator/OpenSSL.framework.dSYM" \
	-output "$PROJ_DIR/build/OpenSSL.xcframework"
