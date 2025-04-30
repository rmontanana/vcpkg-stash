vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rmontanana/mdlp
    REF "v${VERSION}"
    SHA512 6f81930c950a444c15cb439fa100eb0e34922e2304e25427d79db1884298f7fdebecf317173e7f9f75d7c486f5b9d6b7879db25c3e1d14fb9ffd370bdec1eb59
    HEAD_REF main
)


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)
set(VCPKG_BUILD_TYPE release)
set(VCPKG_POLICY_MISMATCHED_NUMBER_OF_BINARIES enabled)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME "fimdlp")
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/mytorchlib)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/tests/lib")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
