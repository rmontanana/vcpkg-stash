vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rmontanana/bayesnet_vcpkg
    REF "v${VERSION}"
    SHA512 762da4a81c98a07f092fbd01864f39786b70f7cfc9a643329b954e1fb6edca0a068a5f50696e72c2f8a24ead95a0d011406bcaca7ba35b1b01a2f19c18d7154e
    HEAD_REF main
    GITHUB_HOST https://gitea.rmontanana.es
)


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)
set(VCPKG_BUILD_TYPE release)
set(VCPKG_POLICY_MISMATCHED_NUMBER_OF_BINARIES enabled)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME "bayesnet")
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/mytorchlib)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/tests/lib")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
