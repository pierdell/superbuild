include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(colormap 89ca7df)

FetchContent_Declare(
    colormap
    GIT_REPOSITORY https://github.com/jgreitemann/colormap
    GIT_TAG ${colormap-tag})

FetchContent_GetProperties(colormap)
if (NOT colormap_POPULATED)
    # Import Only colormap Header library (Without the unit tests)
    FetchContent_Populate(colormap)
endif ()

set(colormap_SOURCE_INCLUDE_DIR ${colormap_SOURCE_DIR}/include)
set(colormap_INSTALL_INCLUDE_DIR ${colormap_INSTALL_DIR}/include)

# Build the library and setup the include dir
add_library(colormap INTERFACE)
target_include_directories(colormap INTERFACE
    "$<INSTALL_INTERFACE:colormap/include>")
set(HDR_EXT "hpp")
SUPERBUILD_INSTALL_TARGET(TARGET colormap
    TARGET_PREFIX colormap
    INCLUDE_DIRECTORY ${colormap_SOURCE_INCLUDE_DIR}/colormap
    INSTALL_DIRECTORY ${colormap_INSTALL_DIR})

SUPERBUILD_DEPENDENCY_FOOTER(colormap lib/cmake)