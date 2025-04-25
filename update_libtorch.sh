#!/usr/bin/env bash

set -euo pipefail

# --- Configuration ---
PORT_NAME="libtorch-bin"
STASH_DIR="/home/rmontanana/Code/vcpkg-stash"
PORT_DIR="${STASH_DIR}/ports/${PORT_NAME}"
VCPKG_JSON="${PORT_DIR}/vcpkg.json"
PORTFILE="${PORT_DIR}/portfile.cmake"
# --- Helper Functions ---
function download_and_hash() {
    local url="$1"
    local tempfile=$(mktemp)
    curl -L "$url" -o "$tempfile"
    sha512sum "$tempfile" | awk '{ print $1 }'
    rm -f "$tempfile"
}

function update_portfile() {
    local linux_sha="$1"
    local macos_sha="$2"

    echo "Updating SHA512 and version in portfile.cmake..."

    # Backup first
    cp "$PORTFILE" "$PORTFILE.bak"

    # Replace Linux SHA512
    sed -i "/linux.*ARCHIVE_SHA512/c\    set(ARCHIVE_SHA512 \"${linux_sha}\")" "$PORTFILE"

    # Replace macOS SHA512
    sed -i "/macos.*ARCHIVE_SHA512/c\    set(ARCHIVE_SHA512 \"${macos_sha}\")" "$PORTFILE"
}

function update_vcpkg_json() {
    local version="$1"

    echo "Updating version in vcpkg.json..."

    # Backup first
    cp "$VCPKG_JSON" "$VCPKG_JSON.bak"

    # Replace version
    sed -i "s/\"version\": \"[^\"]*\"/\"version\": \"${version}\"/" "$VCPKG_JSON"
}

# --- Main Script ---

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <version>"
    exit 1
fi

VERSION="$1"

# URLs to download
LINUX_URL="https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-${VERSION}%2Bcpu.zip"
MACOS_URL="https://download.pytorch.org/libtorch/cpu/libtorch-macos-arm64-${VERSION}.zip"

echo "Downloading and calculating SHA512 for Linux x86-64..."
LINUX_SHA=$(download_and_hash "$LINUX_URL")
echo "Linux SHA512: $LINUX_SHA"

echo "Downloading and calculating SHA512 for macOS arm64..."
MACOS_SHA=$(download_and_hash "$MACOS_URL")
echo "macOS SHA512: $MACOS_SHA"

# Update portfile and vcpkg.json
echo "Updating files..."
update_portfile "$LINUX_SHA" "$MACOS_SHA"
update_vcpkg_json "$VERSION"

# --- Optional: Update versions files if you want full automation (advanced) ---
# echo "Updating versions database..."
# vcpkg x-add-version ${PORT_NAME}


echo "✅ Update complete!"
echo "Check portfile.cmake and vcpkg.json backups .bak files if needed."
