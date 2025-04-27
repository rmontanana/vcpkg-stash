vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rmontanana/ArffFiles
    REF "v${VERSION}"
    SHA512 0fb488b3a258b13fa88932c9939e1b3220efea0b57eeb1fdd1fbde8ae7240410faf37fcf487151f81bdf447b7bcbf50b04ee80b34ee6d427816d1a87dde10bba
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
