OPENSSL_TARBALL="$SRCROOT/openssl-$OPENSSL_VERSION.tar.gz"
OPENSSL_SRC="$TARGET_TEMP_DIR/openssl/"
LIB_PRODUCT_NAME="$FULL_PRODUCT_NAME"

# check whether libcrypto.a already exists - we'll only build if it does not
if [ -f  "$TARGET_BUILD_DIR/$LIB_PRODUCT_NAME" ]; then
    echo "Using previously-built libary $TARGET_BUILD_DIR/$LIB_PRODUCT_NAME - skipping build"
    echo "To force a rebuild clean project and clean dependencies"
    exit 0;
else
    echo "No previously-built libary present at $TARGET_BUILD_DIR/$LIB_PRODUCT_NAME - performing build"
fi

if [ ! -f "$OPENSSL_TARBALL" ]; then
	echo "Downloading openssl-$OPENSSL_VERSION.tar.gz"
	curl -O "https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz" || exit 1
fi

echo "Extracting $OPENSSL_TARBALL..."
mkdir -p "$OPENSSL_SRC"
tar -C "$OPENSSL_SRC" --strip-components=1 -zxf "$OPENSSL_TARBALL" || exit 1

if [ "$SDKROOT" == "" ]; then
    echo "SDKROOT not defined"
	exit 1
fi


echo "Creating $LIB_PRODUCT_NAME for architectures: $ARCHS"

OPENSSL_OPTIONS="no-shared $OPENSSL_OPTIONS"

echo "Using OPENSSL_OPTIONS $OPENSSL_OPTIONS"

cd "$OPENSSL_SRC"

for BUILDARCH in $ARCHS
do
	echo "Building $BUILDARCH"

	make clean

	if [ "$PLATFORM_NAME" = "macosx" ]; then
		if [ "$BUILDARCH" = "i386" ]; then
			OPENSSL_OPTIONS="darwin-i386-cc $OPENSSL_OPTIONS"
		elif [ "$BUILDARCH" = "x86_64" ]; then
			OPENSSL_OPTIONS="darwin64-x86_64-cc $OPENSSL_OPTIONS"
		fi
	elif [ "$PLATFORM_NAME" = "iphoneos" ]; then
		echo "Not done yet"
	else
		echo "Unsupported platform $PLATFORM_NAME"
		exit 1
	fi
	
	./Configure  $OPENSSL_OPTIONS -openssldir="$BUILD_DIR"
	
    make depend
    make CC="$PLATFORM_DEVELOPER_BIN_DIR/gcc" CFLAG="-w -fembed-bitcode -Xanalyzer -arch $BUILDARCH -isysroot $SDKROOT"

	echo "Creating $LIB_PRODUCT_NAME for $BUILDARCH in $TARGET_TEMP_DIR"
    libtool -static libcrypto.a libssl.a -o "$TARGET_TEMP_DIR/$BUILDARCH-$LIB_PRODUCT_NAME"
done


echo "Creating universal archive in $TARGET_BUILD_DIR"
mkdir -p "$TARGET_BUILD_DIR"
lipo -create "$TARGET_TEMP_DIR/"*-$LIB_PRODUCT_NAME -output "$TARGET_BUILD_DIR/$LIB_PRODUCT_NAME"

echo "Executing ranlib"
ranlib "$TARGET_BUILD_DIR/$LIB_PRODUCT_NAME"

echo "Copying Headers"
mkdir -p "$TARGET_BUILD_DIR/headers"
cp -RLf "$OPENSSL_SRC/include/" "$TARGET_BUILD_DIR/headers"
