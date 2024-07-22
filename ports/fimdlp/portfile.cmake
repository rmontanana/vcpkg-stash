vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rmontanana/mdlp
    REF 248a511972f0e33be19cfe2d7bacf18521332b2a
    SHA512 44fe56788f4740a8d9dc403fae6cb79857782dcd89380e49c93840a7adead8cdb471681ce0a41e22f7f612c33425164b07b5366a90ecb981e5ccde142c31e030
    HEAD_REF main
)


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_build()

#vcpkg_cmake_config_fixup(PACKAGE_NAME "fimdlp")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/tests/lib")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
file(INSTALL "${SOURCE_PATH}/src/Discretizer.h" DESTINATION "${CURRENT_PACKAGES_DIR}/include/fimdlp")
file(INSTALL "${SOURCE_PATH}/src/CPPFImdlp.h" DESTINATION "${CURRENT_PACKAGES_DIR}/include/fimdlp")
file(INSTALL "${SOURCE_PATH}/src/BinDisc.h" DESTINATION "${CURRENT_PACKAGES_DIR}/include/fimdlp")
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
