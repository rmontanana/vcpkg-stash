vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rmontanana/bayesnet_vcpkg
    REF "v${VERSION}"
    SHA512 91ba16e8a1b6a5c727c8b287888a136d6111ef97b50df89b6a751df75ad464a6f52fe88d87df89c5bc833f2f983b8f0a0071e57560633af5ca9968c4f238f6cd
    HEAD_REF main
    GITHUB_HOST https://gitea.rmontanana.es
)


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)
set(VCPKG_BUILD_TYPE Release)
set(VCPKG_POLICY_MISMATCHED_NUMBER_OF_BINARIES enabled)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME "bayesnet")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/tests")
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
