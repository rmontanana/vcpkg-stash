vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rmontanana/ArffFiles
    REF "v${VERSION}"
    SHA512 e67124c280bf39db1284d3ec5d3df7a46e24760f6428818b2d8a55ce825d5feef8c843c0be7f860e9d5de67d677e8b8893c95d69a5ba85beb637e09695007f99
    HEAD_REF main
    GITHUB_HOST https://gitea.rmontanana.es
)

# This is a header only library
file(INSTALL "${SOURCE_PATH}/ArffFiles.hpp" DESTINATION "${CURRENT_PACKAGES_DIR}/include/ArffFiles")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/arff-files-config.cmake"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/arff-files"
)

# Handle copyright
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
