vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rmontanana/bayesnet_vcpkg
    REF "v${VERSION}"
    SHA512 a4f3e51d97d81c311c73249e80f33e17dd6415b9530a84495083fc1ea9291b9b31bee935d5af7a15d823bcec15aa51a5d53b21c48a4979ad2dd47e7d37d4e424
    HEAD_REF main
    GITHUB_HOST https://gitea.rmontanana.es
)


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)
set(VCPKG_BUILD_TYPE release)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME "bayesnet" CONFIG_PATH share/bayesnet)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/tests/lib")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
