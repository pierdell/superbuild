include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/dependency_script_utils.cmake)

SUPERBUILD_DEPENDENCY_HEADER(tclap 1.4)

FetchContent_Declare(
    tclap
    GIT_REPOSITORY https://github.com/mirror/tclap
    GIT_TAG ${tclap-tag})

FetchContent_GetProperties(tclap)
if (NOT tclap_POPULATED)
    # Import Only TCLAP Header library (Without the unit tests)
    FetchContent_Populate(tclap)
endif ()

set(TCLAP_SOURCE_INCLUDE_DIR ${tclap_SOURCE_DIR}/include)
set(TCLAP_INSTALL_INCLUDE_DIR ${tclap_INSTALL_DIR}/include)
file(GLOB TCLAP_HEADERS "${tclap_SOURCE_DIR}/include/tclap/*.h")

# Build the library and setup the include dir
add_library(tclap INTERFACE)
target_include_directories(tclap INTERFACE
    "$<INSTALL_INTERFACE:tclap/include>")

SUPERBUILD_INSTALL_TARGET(TARGET tclap
    TARGET_PREFIX tclap
    INCLUDE_DIRECTORY ${TCLAP_SOURCE_INCLUDE_DIR}/tclap
    INSTALL_DIRECTORY ${tclap_INSTALL_DIR})

SUPERBUILD_DEPENDENCY_FOOTER(tclap lib/cmake)