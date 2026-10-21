#!/bin/sh
set -eu

HEADERS_SOURCE_DIR="$TARGET_BUILD_DIR/headers/openssl"
HEADERS_INSTALL_DIR="$BUILT_PRODUCTS_DIR/$PUBLIC_HEADERS_FOLDER_PATH"
: "${SRCROOT:?}"
test -s "$HEADERS_SOURCE_DIR/opensslv.h"
mkdir -p "$HEADERS_INSTALL_DIR"
# Remove headers from older OpenSSL releases and regenerate the umbrella once.
find "$HEADERS_INSTALL_DIR" -maxdepth 1 -type f -name '*.h' -delete
cp "$HEADERS_SOURCE_DIR/"*.h "$HEADERS_INSTALL_DIR/"
cp "$SRCROOT/OpenSSL/OpenSSL.h" "$HEADERS_INSTALL_DIR/OpenSSL.h"
for HEADER in "$HEADERS_INSTALL_DIR/"*.h; do
    sed -i.bak 's|<openssl/|<OpenSSL/|g' "$HEADER"
    rm "$HEADER.bak"
done
for HEADER in "$HEADERS_SOURCE_DIR/"*.h; do
    NAME=$(basename "$HEADER")
    printf '#include <OpenSSL/%s>\n' "$NAME" >> "$HEADERS_INSTALL_DIR/OpenSSL.h"
done
