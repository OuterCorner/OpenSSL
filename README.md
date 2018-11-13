# OpenSSL.framework

![Platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20iOS-lightgrey.svg)
![Carthage](https://img.shields.io/badge/Carthage-compatible-green.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

This project neatly packs OpenSSL into a dynamic framework for iOS and macOS.

Current OpenSSL version used: 1.1.1

## Installation

You have a few different options:

### Manual installation

 *  Include the OpenSSL.xcodeproj as a dependency in your project. This is what the projects under ```Examples/``` are doing. Doing this means OpenSSL will be compiled alongside your project, including after every clean (building OpenSSL can take a while).  
 *  Use a pre-built OpenSSL.framework. You can find them under [Releases](https://github.com/OuterCorner/OpenSSL/releases).

### Carthage

Add OpenSSL as a dependency on your ```Cartfile```:

```
github "OuterCorner/OpenSSL"
```
And run:

```
carthage update
```

By default Carthage will download the pre-build binaries (faster), if you want to compile from source pass ```--no-use-binaries``` to the update command above.

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

## Issues

When including this framework in your project you'll have to set **Allow Non-modular Includes In Framework Modules** to YES.

```
CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES = YES
```

This is needed because the current version of OpenSSL's public headers reference system headers.

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE).

Note the underlying OpenSSL library [LICENSE](https://github.com/openssl/openssl/blob/master/LICENSE) still applies when using this project.

## Acknowledgments

The build scripts for this project were based on:

 * [sqlcipher/openssl-xcode](https://github.com/sqlcipher/openssl-xcode)
 * [keeshux/openssl-apple](https://github.com/keeshux/openssl-apple)
 * [sinofool/build-openssl-ios](https://github.com/sinofool/build-openssl-ios)

