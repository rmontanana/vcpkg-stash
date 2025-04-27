include(CMakeFindDependencyMacro)

# Create the imported interface target
add_library(arff-files::arff-files INTERFACE IMPORTED)

# Calculate the package root (this is where share/folding is located)
get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)

# Tell the target where the headers are
set_target_properties(arff-files::arff-files PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${PACKAGE_PREFIX_DIR}/include"
)
