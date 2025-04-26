# Map triplet → archive URL
if(VCPKG_TARGET_IS_LINUX AND VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
    set(ARCHIVE_NAME "libtorch-cxx11-abi-shared-with-deps-2.7.0%2Bcpu.zip")
    set(ARCHIVE_URL  "https://download.pytorch.org/libtorch/cpu/${ARCHIVE_NAME}")
    set(ARCHIVE_SHA512  "0bdc45f414b7b559854c9bfd6bda93907ea51805908ff8ad2be0c2cc475fda7f7e7468164a0222ec1f64ef441d5be9dca282a78c233432a6faad5c6f1b0a153b")
elseif(VCPKG_TARGET_IS_OSX AND VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
    set(ARCHIVE_NAME "libtorch-macos-arm64-2.7.0.zip")
    set(ARCHIVE_URL  "https://download.pytorch.org/libtorch/cpu/${ARCHIVE_NAME}")
    set(ARCHIVE_SHA512 "674ba3588af3071d90be08a25d600703a08a09eacde1d1606d3b568df156d925927225369a76e3b9576e1ccb53c2accc2705318b5b8e7d5143f2bea8e4878f86")
else()
    message(FATAL_ERROR "${PORT} does not provide binaries for this triplet")
endif()

vcpkg_download_distfile(
    ARCHIVE
    URLS ${ARCHIVE_URL}
    FILENAME ${ARCHIVE_NAME}
    SHA512 ${ARCHIVE_SHA512})

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
)

# Install headers and libraries manually
file(INSTALL "${SOURCE_PATH}/include" DESTINATION "${CURRENT_PACKAGES_DIR}/include")
file(INSTALL "${SOURCE_PATH}/lib" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")

# Optionally install shared resources if they exist
if(EXISTS "${SOURCE_PATH}/share")
    file(INSTALL "${SOURCE_PATH}/share" DESTINATION "${CURRENT_PACKAGES_DIR}/share")
endif()

if(EXISTS "${SOURCE_PATH}/cmake")
    file(INSTALL "${SOURCE_PATH}/cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/cmake")
endif()

# Manually install LICENSE into the share folder
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME "copyright")