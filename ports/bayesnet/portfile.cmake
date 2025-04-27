vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rmontanana/bayesnet
    REF "v${VERSION}"
    SHA512 245e3ad1e7e1d7c9657230a8e77622284b073646f6e877c9226efeeefec43fc915e23b9ee7b19510c94b5622b3b777bcc3fb57f44d2c6181599fb9c5381e6c45
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
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/mytorchlib)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/tests")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
