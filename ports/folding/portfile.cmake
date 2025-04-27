vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rmontanana/folding
    REF "v${VERSION}"
    SHA512 0c86f58e0cb66349bb4e141e3e32a205a264daef6ffbd6284f76a2bb4deb303f752eb85954cd78082900a356da1940e1cf74c9732752b208f5dbf36f28ecfd2e
    HEAD_REF main
    GITHUB_HOST https://gitea.rmontanana.es
)

# This is a header only library
file(INSTALL "${SOURCE_PATH}/folding.hpp" DESTINATION "${CURRENT_PACKAGES_DIR}/include")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/folding-config.cmake"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/folding"
)

# Handle copyright
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")