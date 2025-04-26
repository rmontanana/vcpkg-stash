vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO doctorado-ml/bayesnet
    REF "v${VERSION}"
    SHA512 25a723a5f83184b78cdb5f8dd7de84ae91c37b54c04dd44d259ceac0cb1a290dbab04add6902eca6cb826302d3259d5e3a06c1e53cba1b0f7523802ad29ce0ba
    HEAD_REF main
)


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)
set(VCPKG_BUILD_TYPE release)
set(VCPKG_POLICY_MISMATCHED_NUMBER_OF_BINARIES enabled)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME "bayesnet")
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/mytorchlib)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/tests")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
