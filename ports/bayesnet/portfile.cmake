vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rmontanana/bayesnet_vcpkg
    REF "v${VERSION}"
    SHA512 ff38d3bd91c2c54662ecf6d90e291afcb6e73b3c154a4931d1a227454ef1f48c218b237440cb29208e776b15cfd2db71031142e4ea6bcbdfa47ae7b7589377aa
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
