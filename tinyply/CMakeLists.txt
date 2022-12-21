include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(tinyply 2.4)

FetchContent_Declare(
    tinyply
    GIT_REPOSITORY https://github.com/ddiakopoulos/tinyply
    GIT_TAG ${tinyply-tag})

FetchContent_GetProperties(tinyply)
if (NOT tinyply_POPULATED)
    # Import Only tinyply Header library (Without the unit tests)
    FetchContent_Populate(tinyply)
endif ()

set(tinyply_SOURCE_INCLUDE_DIR ${tinyply_SOURCE_DIR}/source)
set(tinyply_INSTALL_INCLUDE_DIR ${TINYPLY_INSTALL_DIR}/include)

add_library(tinyply SHARED ${tinyply_SOURCE_DIR}/source/tinyply.cpp)
target_include_directories(tinyply INTERFACE
    "$<INSTALL_INTERFACE:tinyply/include>")
set(HDR_EXT "h")

SUPERBUILD_INSTALL_TARGET(TARGET tinyply
    TARGET_PREFIX tinyply
    INCLUDE_DIRECTORY ${tinyply_SOURCE_INCLUDE_DIR}/tinyply
    INSTALL_DIRECTORY ${tinyply_INSTALL_DIR})

SUPERBUILD_DEPENDENCY_FOOTER(tinyply lib/cmake)