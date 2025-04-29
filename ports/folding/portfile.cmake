vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rmontanana/folding
    REF "v${VERSION}"
    SHA512 6220851b844ede5874cc6ca1dd384ff90006c2048313b89d521b50155212997e8bf02e6046ab63774786f6c471ecd07c5639ddfd4ce2f1b55ac96408d50aad4c
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