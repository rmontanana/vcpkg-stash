vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rmontanana/bayesnet_vcpkg
    REF "v${VERSION}"
    SHA512 1c68e3c30d6b2a60cab460e678562752bfa2855456c157d878d2af2efce6821c6550645807756838b894209bb3a181e8ad9a441d0aaf877260bbae2954cffffe
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
